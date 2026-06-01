local blink_fuzzy = { "not-manu/filemention.nvim", event = "InsertEnter", opts = {} }

local blink_compact = {
  'saghen/blink.cmp',
  dependencies = {
    "fang2hou/blink-copilot",
    'rafamadriz/friendly-snippets' ,
    'mayromr/blink-cmp-dap',
    'ribru17/blink-cmp-spell', "mikavilpas/blink-ripgrep.nvim",
    opts = {
      max_completions = 1,  -- Global default for max completions
      max_attempts = 2,     -- Global default for max attempts
    }
  },

  version = '1.*',
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'default',
      ['<Tab>'] = { 'accept', 'fallback' },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      documentation = { auto_show = false },
      ghost_text = { enabled = false },
    },

    cmdline = {
      -- keymap = { preset = 'inherit' },
      completion = { menu = { auto_show = true } },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp',
      'path',
      'filemention',
      'snippets', 'buffer',
      'copilot',
      'cmdline', 'spell' , 'ripgrep', 'lazydev', 'dap'},
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
          opts = {
            -- Local options override global ones
            max_completions = 2,  -- Override global max_completions

            -- Final settings:
            -- * max_completions = 3
            -- * max_attempts = 2
            -- * all other options are default
          }
        },
        dap = {
          name = "dap",
          module = "blink-cmp-dap",
          opts = {
            -- See the full configuration below for all available options
            ---@module "blink-cmp-dap"
            ---@type blink-cmp-dap.Options
            -- opts = {},
          },
        },
        filemention = {
          name = "filemention",
          module = "filemention.sources.blink",
        },
        spell = {
          name = 'Spell',
          module = 'blink-cmp-spell',
          opts = {
            -- EXAMPLE: Only enable source in `@spell` captures, and disable it
            -- in `@nospell` captures.
            enable_in_context = function()
              local curpos = vim.api.nvim_win_get_cursor(0)
              local captures = vim.treesitter.get_captures_at_pos(
                0,
                curpos[1] - 1,
                curpos[2] - 1
              )
              local in_spell_capture = false
              for _, cap in ipairs(captures) do
                if cap.capture == 'spell' then
                  in_spell_capture = true
                elseif cap.capture == 'nospell' then
                  return false
                end
              end
              return in_spell_capture
            end,
          },
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
        path = {
          opts = {
            -- start from the current working directory instead of the buffer's directory
            get_cwd = function(_)
              return vim.fn.getcwd()
            end,
          },
        },
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
          -- see the full configuration below for all available options
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          opts = {},
        },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}

local M = {}
table.insert(M, blink_compact)
table.insert(M, blink_fuzzy)
return M
