local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup {
  "nvim-lua/plenary.nvim",

  -- THEMES -------------------------------------------------------------------------------------------------------
  "mvpopuk/inspired-github.vim",
  {
    "projekt0n/github-nvim-theme",
    config = function()
      --require("github-theme").setup {
      -- 	theme_style = "light",
      -- 	colors = {bg = "#f5f5f5"},
      -- 	keyword_style = "bold",
      -- 	comment_style = "italic",
      -- }
    end,
  },
  {
    "JoseConseco/hl_manager.nvim",
    -- dev = true,
    -- dir = '/home/bartosz/.local/share/nvim/lazy/hl_manager.nvim/',
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    -- branch = "feat/interactive",
    -- commit = "c88664b18e593319aea1ded731dd252d4f9e0f9a", -- before day-fox refactor, not looking goodd
    config = function()
      require "nv-nightfox"
    end,
  },
  {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    dependencies = "rktjmp/lush.nvim",
  },
  {
    "m-demare/hlargs.nvim",
    -- after = "nightfox.nvim",
    config = function()
      local palette = require("nightfox.palette").load "nightfox"
      require("hlargs").setup {
        color = palette.cyan.bright, -- color of 'ident' - how to make it work for all themes?
        paint_arg_declarations = false,
        excluded_argnames = {
          declarations = {
            python = { "self", "cls" },
            lua = { "self" },
          },
          usages = {
            python = { "self", "cls" },
            lua = { "self" },
          },
        },
      }
      local hl_manager = require "hl_manager"
      hl_manager.highlight_link("Hlargs", "@parameter")
    end,
  },
  {
    "folke/tokyonight.nvim",
    init = function()
      require "themes.tokyonight"
    end,
    -- config=function() vim.cmd('colorscheme tokyonight'); vim.cmd([[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]])end
  }, -- lua + wont close () next to char finally good and simple +++

  -- -- UI -------------------------------------------------------------------------------------------------------
  {
    -- "norcalli/nvim-colorizer.lua",  -- original repo - not maintained
    "NvChad/nvim-colorizer.lua", -- colorize hex, rgb, hsl colors
    config = function()
      require("colorizer").setup {
        filetypes = { "css", "lua", "html" },
      }
    end,
  }, --color highlighter
  { "shortcuts/no-neck-pain.nvim" },
  {
    "azabiong/vim-highlighter", -- highlight selection and occurrences
    event = "VeryLazy",
    config = function()
      vim.cmd [[let HiClearUsingOneTime = 1]]
      vim.cmd [[let HiSyncMode = 1]]
      vim.cmd [[let HiFindTool = 'rg -H --color=never --no-heading --column --smart-case']]
    end,
  },
  {
    "folke/twilight.nvim",
    -- "mkonig/twilight.nvim",
    event = "VeryLazy",
    -- branch = "pr/1", -- my fix for expand props
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.4, -- amount of dimming
          -- color = { "Normal", "#ffffff" }, -- we try to get the foreground from the highlight groups or fallback color
          inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
        },
        context = 0, -- amount of lines we will try to show around the current line
        node_context = 0,
        treesitter = true, -- use treesitter when available for the filetype
        -- treesitter is used to automatically expand the visible text,
        -- but you can further control the types of nodes that should always be fully expanded
        expand = {
          -- "function",
          -- "if_expression",
          -- python/pyright
          -- "while_statement",
          -- "if_statement",
          -- "for_statement",
          -- "block",
          "function_definition",
          "method_definition",
          "class_definition",
          -- yml
          -- "document",
          -- lua
          -- "function_declaration",
        },
      }
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    -- dependencies = "nvim-tree/nvim-web-devicons", -- broken??? wtf. works eg. eblow ok..
    config = function()
      require "web-devicons"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "nv-lualine"
    end,
  },
  {
    -- cmd line replacer
    "folke/noice.nvim",
    event = "VimEnter",
    cond = true,
    config = function()
      require "nv-noice"
    end,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  { -- better vim.ui  - eg. vim.input, vim.select etc.
    "stevearc/dressing.nvim",
    lazy = true,
    -- init = function()
    --   ---@diagnostic disable-next-line: duplicate-set-field
    --   vim.ui.select = function(...)
    --     require("lazy").load { plugins = { "dressing.nvim" } }
    --     return vim.ui.select(...)
    --   end
    --   ---@diagnostic disable-next-line: duplicate-set-field
    --   vim.ui.input = function(...)
    --     require("lazy").load { plugins = { "dressing.nvim" } }
    --     return vim.ui.input(...)
    --   end
    -- end,
  },

  {
    "smjonas/live-command.nvim",
    -- live-command supports semantic versioning via tags
    -- version = "1.*",
    config = function()
      require("live-command").setup {
        commands = {
          Norm = { cmd = "norm" },
          G = { cmd = "g" },
          S = { cmd = "substitute" },
          -- Reg = {
          --   cmd = "norm",
          --   -- This will transform ":5Reg a" into ":norm 5@a"
          --   args = function(opts)
          --     return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
          --   end,
          --   range = "",
          -- },
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    after = "nightfox.nvim",
    config = function()
      require "nv-indentline"
    end,
  },
  {
    "petertriho/nvim-scrollbar", -- scrollbar with marked errors and search results
    cond = true, -- scrollbar which shows search resutls   and errors
    config = function()
      require "nv-nvim-scrollbar"
    end,
  },

  {
    "karb94/neoscroll.nvim", -- smooth scroll
    cond = true,
    config = function()
      local neoscroll = require "neoscroll"
      neoscroll.setup { hide_cursor = false }
      local keymap = {
        -- ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
        -- ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
        -- ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 450 }) end;
        -- ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 450 }) end;
        -- ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
        -- ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
        -- ["zt"]    = function() neoscroll.zt({ half_screen_duration = 250 }) end;
        -- ["zz"]    = function() neoscroll.zz({ half_screen_duration = 250 }) end;
        -- ["zb"]    = function() neoscroll.zb({ half_screen_duration = 250 }) end;
        -- ["G"] = function()
        --   neoscroll.G {}
        -- end, -- throw error..
        -- ["gg"] = function()
        --   neoscroll.gg {}
        -- end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
  },

  -- WINDOWS MANAGER  -------------------------------------------------------------------------------------------------------
  {
    "nvim-focus/focus.nvim",
    cond = false, -- autoresize windows to gold ration - replaced with "anuvyklack/windows.nvim"
    config = function()
      require("focus").setup {
        enabled = true,
        excluded_filetypes = { "fzf", "oil" },
      }
    end,
  },
  {
    -- "anuvyklack/windows.nvim", -- auto expand windows
    "JoseConseco/windows.nvim", -- auto expand windows - fork with auto height support
    cond = true,
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winminwidth = 5
      vim.o.winwidth = 15
      vim.o.equalalways = false
      require("windows").setup {
        autoboth = {
          enable = true,  -- takes settings from autowidth and autoheight
        },
        autowidth = {
          enable = false,
          winwidth = 1.5,
          filetype = {			--	      |windows.autowidth.filetype|
             help = 2,
          },
        },
        autoheight = {
          enable = false,
          winheight = 0.62,
          filetype = {			--	      |windows.autowidth.filetype|
             help = 2,
          },
        },
        ignore = {
          --			  |windows.ignore|
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "DiffviewFiles", "oil" },
        },
        animation = {
          duration = 200, -- ms
        },
      }
    end,
  },
  {
    url = "https://gitlab.com/yorickpeterse/nvim-window.git", -- pick window quickly
    config = function()
      vim.api.nvim_set_keymap("n", "<c-w>w", ":lua require('nvim-window').pick()<CR>", { noremap = true, silent = true })
    end,
  },
  {
    -- "sindrets/winshift.nvim", -- original gives error about Color Name not recognized
    "jam1015/winshift.nvim", -- form PR
    branch = "fix_colors",
    cmd = "WinShift",
    config = function()
      require("winshift").setup {
        highlight_moving_win = true, -- Highlight the window being moved
        focused_hl_group = "Visual", -- The highlight group used for the moving window
        moving_win_options = {
          -- These are local options applied to the moving window while it's
          -- being moved. They are unset when you leave Win-Move mode.
          wrap = false,
          cursorline = false,
          cursorcolumn = false,
          colorcolumn = "",
        },
        keymaps = {
          disable_defaults = true,
        },
      }
    end,
  },

  -- DEBUGGING  -------------------------------------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap", --too simple
    lazy = true,
    config = function()
      require "dap"
      require "nv-dap"
    end,
  }, -- preview linecmp_nvim_ultisnips whe using goto :xyz
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "/usr/bin/python"
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true, -- enable this plugin (the default)
        enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did notify its termination)
        highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        show_stop_reason = true, -- show stop reason when stopped for exceptions
        commented = false, -- prefix virtual text with comment string
        -- experimental features:
        virt_text_pos = "right_align", -- position of virtual text, see :h nvim_buf_set_extmark() - 'right_align', 'eol', 'overlay'
        all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        all_references = true, -- show virtual text for all references not only current. Only works for debugpy on my machine.
        virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
        virt_text_win_col = 85, -- position the virtual text at a fixed window column (starting from the first text column) ,
        -- e.g. 80 to position at column 80 see :h nvim_buf_set_extmark()
      }
      -- vim.api.nvim_exec("highlight! link NvimDapVirtualText DiagnosticVirtualTextInfo", false)
      -- vim.api.nvim_exec("highlight! link NvimDapVirtualTextChanged DiagnosticVirtualTextWarn", false)
      -- not sure why this works but above wont

      local hl_manager = require "hl_manager"
      hl_manager.highlight_link("NvimDapVirtualText", "DiagnosticVirtualTextInfo")
      hl_manager.highlight_link("NvimDapVirtualTextChanged", "DiagnosticVirtualTextWarn")
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    -- commit = "6b6081ad244ae5aa1358775cc3c08502b04368f9", -- till fix is merged
    config = function()
      require "nv-dapui"
    end,
  },

  {
    "folke/lazydev.nvim", -- for lua plugs
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "luvit-meta/library",
        -- You can also add plugins you always want to have loaded.
        -- Useful if the plugin has globals or types you want to use
        -- vim.env.LAZY .. "/LazyVim", -- see below
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings for 'folke/lazydev.'
  {
    "jbyuki/one-small-step-for-vimkind",
    config = function()
      local dap = require "dap"
      dap.configurations.lua = {
        {
          type = "nlua",
          request = "attach",
          name = "Attach to running Neovim instance",
          host = function()
            local value = vim.fn.input "Host [127.0.0.1]: "
            if value ~= "" then
              return value
            end
            return "127.0.0.1"
          end,
          port = function()
            local val = tonumber(vim.fn.input "Port: ")
            assert(val, "Please provide a port number")
            return val
          end,
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback { type = "server", host = config.host, port = config.port or 8088 }
      end
    end,
  },

  -- Treesitter    -------------------------------------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require "treesitter"
    end,
  },
  { -- for incremental selection only...
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = true, -- cool but gives orror on compe-popup - https://github.com/romgrk/nvim-treesitter-context/issues/49
    config = function()
      require "nv-treesittercontext"
    end,
  },
  {
    "mizlan/iswap.nvim",
    -- "JoseConseco/iswap.nvim",

    config = function()
      require("iswap").setup {
        hl_snipe = "ErrorMsg",
        autoswap = true,
        move_cursor = true,
        flash_style = false,
        hl_selection = "",
      }
    end,
  },
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"

      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterBlue",
          "RainbowDelimiterYellow",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      }
      -- add colorscheme change hook
      local hl_manager = require "hl_manager"
      hl_manager.match_color_to_highlight("#df717a", "@keyword", "RainbowDelimiterRed", "foreground")
      hl_manager.match_color_to_highlight("#6ea1ec", "@keyword", "RainbowDelimiterBlue", "foreground")
      hl_manager.match_color_to_highlight("#ebcb8b", "@keyword", "RainbowDelimiterYellow", "foreground")
      hl_manager.match_color_to_highlight("#d08770", "@keyword", "RainbowDelimiterOrange", "foreground")
      hl_manager.match_color_to_highlight("#a3be8c", "@keyword", "RainbowDelimiterGreen", "foreground")
      hl_manager.match_color_to_highlight("#b48ead", "@keyword", "RainbowDelimiterViolet", "foreground")
      hl_manager.match_color_to_highlight("#88c0d0", "@keyword", "RainbowDelimiterCyan", "foreground")
    end,
  },
  "nvim-treesitter/playground",

  -- lsp -------------------------------------------------------------------------------------------------------
  "onsails/lspkind-nvim", -- icons for completion popup
  -- {
  --   "williamboman/mason.nvim",
  --   config = function()
  --     require("mason").setup()
  --     require("mason-lspconfig").setup()
  --   end,
  -- },
  -- "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "nv-lsp"
    end,
  }, -- lua + wont close () next to char finally good and simple +++

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "nv-lsptrouble"
    end,
  },
  -- {
  --   "carbon-steel/detour.nvim",
  --   -- branch="dev",
  --   config = function()
  --     require "nv-detour"
  --   end,
  -- },
  {
    "SirVer/ultisnips",
    -- lazy = true,
    config = function()
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
      vim.cmd [[autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets]]
    end,
  },
  {
    "stevearc/aerial.nvim", -- basically better outliner with objects type filter
    config = function()
      require "nv-aerial"
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    enabled = true,
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-treesitter/nvim-treesitter" } },
    config = function()
      require "nv-refactoring"
    end,
  },
  {
    -- "jose-elias-alvarez/null-ls.nvim", -- abandoned
    "nvimtools/none-ls.nvim",
    -- cond = false,
    config = function()
      require "nv-null"
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "ruff-lsp" }, -- has to be set in lsp - config...
        },
      }
    end,
  },

  -- AUTO-COMPLETE -------------------------------------------------------------------------------------------------------
  {
    "github/copilot.vim",
    cond = false,
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.g.copilot_filetypes = { ["dap-repl"] = false }
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = false, -- Enable debugging
      auto_follow_cursor = false,
      -- See Configuration section for rest
      model = 'claude-3.5-sonnet',

      -- default mappings
      mappings = {
        complete = {
          detail = "Use @<Tab> or /<Tab> for options.",
          insert = "<Tab>",
        },
        close = {
          normal = "q",
          insert = "<C-c>",
        },
        reset = {
          normal = "<C-l>",
          insert = "<C-l>",
        },
        submit_prompt = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        accept_diff = {
          normal = "A",
          insert = "A",
        },
        yank_diff = {
          normal = "gy",
          register = '"',
        },
        show_diff = {
          normal = "gd",
        },
        show_info = {
          normal = "gp",
        },
        show_context = {
          normal = "gs",
        },
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- {'tzachar/cmp-ai', dependencies = 'nvim-lua/plenary.nvim'},
  { "JoseConseco/cmp-ai", dependencies = "nvim-lua/plenary.nvim" },
  {
    "iguanacucumber/magazine.nvim", -- faster versioon of "hrsh7th/nvim-cmp"
    name = "nvim-cmp",    -- Otherwise highlighting gets messed up
    cond = true,
    event = "InsertEnter",
    dependencies = {
      -- 'tzachar/cmp-ai',
      "JoseConseco/cmp-ai",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      -- "quangnguyen30192/cmp-nvim-ultisnips",
      "hrsh7th/cmp-calc",
      "lukas-reineke/cmp-rg",
      "rcarriga/cmp-dap",
      -- "hrsh7th/cmp-nvim-lsp-signature-help", - x ray better
      -- "uga-rosa/cmp-dictionary", -- based on custom dict
      "f3fora/cmp-spell", -- vim spell hast to be enabled
      "runiq/neovim-throttle-debounce", -- for debouncing of cmp complettions...
    },
    config = function()
      require "nv-cmp"
    end,
  },
  { "quangnguyen30192/cmp-nvim-ultisnips", dependencies = { "iguanacucumber/magazine.nvim" } },
  { "dmitmel/cmp-cmdline-history", dependencies = "hrsh7th/cmp-cmdline" },
  -- require "nv-blink", -- comp=ai wont work
  -- { "tzachar/cmp-fuzzy-path", dependencies = { "iguanacucumber/magazine.nvim", "hrsh7th/cmp-path", "tzachar/fuzzy.nvim" } }
  -- use { "tzachar/cmp-fuzzy-buffer", dependencies = { "iguanacucumber/magazine.nvim", "tzachar/fuzzy.nvim" } }
  -- {
  --   "tzachar/cmp-tabnine",
  --   cond = false,
  --   event = "InsertEnter",
  --   dependencies = "iguanacucumber/magazine.nvim",
  --   build = "./install.sh",
  --   config = function()
  --     require("cmp_tabnine.config"):setup {
  --       max_lines = 100,
  --       max_num_results = 3,
  --       sort = true,
  --     }
  --   end,
  -- },
  {
    "tzachar/highlight-undo.nvim",
    -- commit="1ea1c79372d7d93c88fd97543880927b7635e3d2",
    config = function()
      require("highlight-undo").setup {
        undo = {
          hlgroup = "@text.danger", --'HighlightUndo',
        },
        redo = {
          hlgroup = "@text.todo", --'HighlightUndo',
        },
        duration = 400,
      }
    end,
  },
  {
    "zbirenbaum/copilot.lua", -- alternative in lua
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = true, auto_trigger = true, debounce = 100 },
        panel = { enabled = false },
        filetypes = { markdown = true },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
    dependencies = { "copilot.lua", "nvim-cmp" },
    config = function()
      require("copilot_cmp").setup { event = "LspAttach" }
    end,
  },

  -- Telescope   -------------------------------------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
      "JoseConseco/telescope_sessions_picker.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require "telescope-nvim"
    end,
  }, -- lua + wont lose () next to char finally good and simple +++
  "nvim-telescope/telescope-media-files.nvim",
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      "stevearc/dressing.nvim", -- optional, if using telescope for vim.ui.select
    },
    config = function()
      require "nv-telescope-all-recent"
    end,
    opts = {
      -- your config goes here
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },

  -- Explorer  -------------------------------------------------------------------------------------------------------
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup {}
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilEnter",
        callback = vim.schedule_wrap(function(args)
          local oil = require("oil")
          if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
            oil.open_preview()
          end
        end),
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cond = false,
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, for file icons },
    config = function()
      require "nvimTree"
    end,
    tag = "nightly", -- optional, updated every week. (see issue #1193)
  },
  {
    "Isrothy/neominimap.nvim", -- ok but low on big buffer enter..
    version = "v3.*.*",
    enabled = true, -- even when auto_enable false - it will still lagg
    lazy = false, -- NOTE: NO NEED to Lazy load
    init = function()
      -- The following options are recommended when layout == "float"
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36 -- Set a large value

      --- Put your configuration here
      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = false,
        -- log_level = vim.log.levels.TRACE,

        layout = "float",
        float = { z_index = 10 },
        diagnostic = {
          enabled = false,
        },
        git = {
          enabled = true,
          mode = "line",
        },
        search = {
          enabled = true,
          mode = "sign",
        },
        win_filter = function(winid)
          return winid == vim.api.nvim_get_current_win()
        end,
      }
      -- link NeominimapGitAddLine highlight to DiffAdd
      vim.api.nvim_set_hl(0, "NeominimapGitAddLine", { link = "DiffAdd" })
      vim.api.nvim_set_hl(0, "NeominimapGitChangeLine", { link = "DiffChange" })
      vim.api.nvim_set_hl(0, "NeominimapGitDeleteLine", { link = "DiffDelete" })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim", -- nice buffers preview...
    cond = true,
    branch = "v2.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", "s1n7ax/nvim-window-picker" },
    keys = {
      { "<F11>", "<cmd>NeoTreeFloat<cr>", desc = "Open Neotree on side" },
      { " bb", "<cmd>NeoTreeFloat buffers<cr>", desc = "Open Neotree on side" },
    },
    config = function()
      require "nv_neotree"
    end,
  },
  -- Git  -------------------------------------------------------------------------------------------------------
  -- { "tpope/vim-fugitive", -- add :Gitxx commands },
  {
    "NeogitOrg/neogit",
    cond = true,
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup()
      local hl_manager = require "hl_manager"
      hl_manager.highlight_from_src("NeogitDiffContext", "Normal", { bg = -5 })
      hl_manager.highlight_link("NeogitDiffContextHighlight", "Normal", { bg = 5 })
      -- hl_manager.highlight_link("NeogitDiffAdd", "NeogitDiffAdd")
      -- hl_manager.highlight_link("NeogitDiffDelete", "NeogitDiffDelete")

      hl_manager.highlight_link("NeogitDiffAddHighlight", "NeogitDiffAdd")
      hl_manager.highlight_from_src("NeogitDiffAddCursor", "NeogitDiffAddHighlight", { fg = 25 })

      hl_manager.highlight_link("NeogitDiffDeleteHighlight", "NeogitDiffDelete")
      hl_manager.highlight_from_src("NeogitDiffDeleteCursor", "NeogitDiffDeleteHighlight", { fg = 25  })
      -- hl_manager.highlight_link("NeogitDiffAddHighlight", "NeogitDiffAdd")
    end,
  },
  {
      "ldelossa/gh.nvim", -- for merging/reviewing PRs
      dependencies = {
          {
          "ldelossa/litee.nvim",
          config = function()
              require("litee.lib").setup()
          end,
          },
      },
      config = function()
          require("litee.gh").setup()
      end,
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true }, -- for solving git
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          -- vim-surround style keymaps
          -- insert = "ys",
          visual = "s",
          delete = "ds",
          change = "cs",
        },
      }
    end,
  },
  -- { "tpope/vim-repeat" },
  {
    "lewis6991/foldsigns.nvim", -- for git signs in fildes?
    config = function()
      require("foldsigns").setup()
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "lewis6991/foldsigns.nvim" },
    config = function()
      require "nv-gitsigns"
    end,
  }, -- lua + wont close () next to char finally good and simple +++
  {
      "f-person/git-blame.nvim",
      -- load the plugin at startup
      event = "VeryLazy",
      -- Because of the keys part, you will be lazy loading this plugin.
      -- The plugin wil only load once one of the keys is used.
      -- If you want to load the plugin at startup, add something like event = "VeryLazy",
      -- or lazy = false. One of both options will work.
      opts = {
          -- your configuration comes here
          -- for example
          enabled = true,  -- if you want to enable the plugin
          message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
          date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
          virtual_text_column = 1,  -- virtual text start column, check Start virtual text at column section for more options
      },

  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,

        file_panel = {
          listing_style = "tree",             -- One of 'list' or 'tree'
          tree_options = {                    -- Only applies when listing_style is 'tree'
            flatten_dirs = true,              -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
          },
          win_config = {                      -- See |diffview-config-win_config|
            position = "bottom",
            height = 15,
            win_opts = {},
          },
        },
      }
    end,
  },

  -- general  -------------------------------------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require "nv-which-key"
    end,
  },
  {
    "nvimtools/hydra.nvim", -- original not longer maintained -"anuvyklack/hydra.nvim"
    -- cond = false,
    dependencies = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
    config = function()
      require "nv-hydra"
    end,
  },
  {
    "folke/todo-comments.nvim", -- original
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require "nv-todo"
    end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim", -- increase speed of jk after n jumps
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
      require("accelerated-jk").setup {
        mode = "time_driven",
        enable_deceleration = false,
        acceleration_limit = 150,
        acceleration_table = { 5, 29 }, -- after 25js, jump to next speed
        deceleration_table = { { 550, 9999 } },
      }
    end,
  },

  --find and replace ? -------------------------------------------------------------------------------------------------------
  {
    "kevinhwang91/nvim-bqf", --better quickfix  (with preview and complicated mapping)
    enabled=false,
    config = function()
      require("bqf").setup {
        auto_enable = true,
        auto_resize_height = true, -- highly recommended enable
        preview = { -- stefandtw/quickfix-reflector.vim breaks this
          auto_preview = false,
        },
        func_map = {
          open = "<CR>",
          openc = "o",
          drop = "O",
          split = "<C-x>",
          vsplit = "<C-v>",
          tab = "t",
          tabb = "T",
          tabc = "<C-t>",
          tabdrop = "",
          ptogglemode = "zp",
          ptoggleitem = "p",
          ptoggleauto = "P",
          pscrollup = "<C-b>",
          pscrolldown = "<C-f>",
          pscrollorig = "zo",
          -- prevfile = '<C-p>',#
          -- nextfile = '<C-n>', - disable for multi-cursor - still broken...
          prevhist = "<",
          nexthist = ">",
          lastleave = [['"]],
          stoggleup = "<S-Tab>",
          stoggledown = "<Tab>",
          stogglevm = "<Tab>",
          stogglebuf = [['<Tab>]],
          sclear = "z<Tab>",
          filter = "zn",
          filterr = "zN",
          fzffilter = "zf",
        },
        -- create autocmd for 'qf' filetype. It will create 2 buffer levels mappings: for j and k keys.
        -- These keys will send 'pp' keys to refresh the preview window.
      }
    end,
  },
  -- "stefandtw/quickfix-reflector.vim", -- edit quickfix list as text - :w to save to multi files
  {
    "stevearc/quicker.nvim", -- lua version of above list as text - :w to save to multi files
    config = function()
      require("quicker").setup {
        keys = {
          {
            ">",
            function()
              require("quicker").expand { before = 2, after = 2, add_to_existing = true }
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      }
    end,
  },
  "dyng/ctrlsf.vim", --Run :CtrlSF [pattern]
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup {
        engines = {
          astgrep = { path = "ast-grep" },
        },
        engine = "astgrep",
        folding = { enabled = false },
      }
    end,
  },
  "eugen0329/vim-esearch", -- Grepper
  { "nvim-pack/nvim-spectre", dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } },

  --UNDO REDO  -------------------------------------------------------------------------------------------------------
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require "nv-neoclip"
    end,
  },
  "mbbill/undotree", -- undo history  :UndotreeToggle to toggle the undo-tree panel.
  "mg979/vim-localhistory", -- local history LHLoad, LHWrite

  --CODE/FORMAT -------------------------------------------------------------------------------------------------------
  -- "wellle/targets.vim", -- eg ci,  ci_ etc replaced by mini.ai
  {
    "Wansmer/treesj", -- better SplitJoin - mapped in keymappings.lua  >TSJToggle
    requires = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup { max_join_length = 820 }
    end,
  },
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup {
        auto_cmd = true,
      }
    end,
  },
  {
    "urxvtcd/vim-indent-object",
    init = function()
      local modes = { "x", "o" }
      for _, mode in ipairs(modes) do
        vim.api.nvim_set_keymap(mode, "ii", "<Plug>(indent-object_linewise-none)", { noremap = true })
        vim.api.nvim_set_keymap(mode, "ai", "<Plug>(indent-object_linewise-start)", { noremap = true })
        vim.api.nvim_set_keymap(mode, "iI", "<Plug>(indent-object_linewise-end)", { noremap = true })
        vim.api.nvim_set_keymap(mode, "aI", "<Plug>(indent-object_linewise-both)", { noremap = true })
        -- one way expand
        vim.api.nvim_set_keymap(mode, "ik", "<Plug>(indent-object_linewise-none-keep-end)", { noremap = true })
        vim.api.nvim_set_keymap(mode, "ij", "<Plug>(indent-object_linewise-none-keep-start)", { noremap = true })
      end
    end,
  },
  {
    "andymass/vim-matchup", -- slow as hell still in 2023 dec
    enabled = true, -- increase power of % - slow as hell (not any more?) higlights fun, if etc. ranges
    init = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_deferred_show_delay = 180
    end,
    config = function()
      vim.g.matchup_matchparen_deferred = 1
    end,
  },

  {
    "briangwaltney/paren-hint.nvim", -- show matching paren by ghost text
    enabled = true,
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      -- you can create a custom highlight group for the ghost text with the below command.
      -- change the `highlight` option to `parenhint` if you use this method.
      -- vim.api.nvim_exec([[ highlight parenhint guifg='#56633E' ]], false)
      require("paren-hint").setup {
        -- Include the opening paren in the ghost text
        include_paren = true,

        -- Show ghost text when cursor is anywhere on the line that includes the close paren rather just when the cursor is on the close paren
        anywhere_on_line = true,

        -- show the ghost text when the opening paren is on the same line as the close paren
        show_same_line_opening = false,

        -- style of the ghost text using highlight group
        -- :Telescope highlights to see the available highlight groups if you have telescope installed
        highlight = "@attribute",
      }
    end,
  },

  {
    "windwp/nvim-autopairs", -- lua + wont close () next to char finally good and simple +++
    config = function()
      require "nv-autopairs"
    end,
  },
  -- "JoseConseco/vim-case-change", -- rotate strign case - modded by me
  {
    "johmsalas/text-case.nvim", -- ga then eg. u for upper  case (gau)
    config = function()
      require("textcase").setup {}
    end,
  },
  {
    "mg979/vim-visual-multi", --multi cursor
    init = function()
      vim.g.VM_maps = { -- fixes first ctrl+n in visual mode not working.
        ["I BS"] = "",
      }
    end,
    -- config = function()
    --   vim.g.VM_mouse_mappings = 1
    --   -- vim.cmd [[VMDebug]]
    -- end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require "nv-mini"
    end,
  },
  {
    -- increse decrease numbers but also datas, true to false etc
    "monaqa/dial.nvim",
    config = function()
      require "nv-dial"
    end,
  },

  -- navigation  -------------------------------------------------------------------------------------------------------
  {
    "folke/flash.nvim",
    cond = true,
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "  ",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
      },
      {
        "u", -- unit textobject
        mode = { "o", "x" },
        function()
          require("flash").treesitter {
            filter = function(matches)
              ---@param m Flash.Match.TS
              -- for all matches,  match[n+1] should use previous match[n] label. Do in reverse order, to prevet copying first label to all matches
              for i = #matches, 2, -1 do
                matches[i].label = matches[i - 1].label
              end
              table.remove(matches, 1) -- remove first match, as it is same as word under cursor thus redundant with word motion
            end,
            label = {
              rainbow = {
                enabled = true,
              },
            },
          }
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = { "o", "x" }, -- remote search (treesitter)
        function()
          require("flash").treesitter_search {
            label = {
              rainbow = {
                enabled = true,
              },
            },
            remote_op = { restore = true, motion = true },
          }
        end,
        desc = "Flash Treesitter Search",
      },
      {
        "gl",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump {
            search = { mode = "search", max_length = 0 }, -- len == 0  so all labels will be used and skips won't be calculated
            label = { after = { 0, 0 } },
            highlight = {
              matches = false, -- to hide the whitespace match
            },
            jump = { pos = "end" }, -- jump to end of match regex (so to first non-whitespace char)
            pattern = "^\\s*\\S", -- match non-whitespace at start plus any character (ignores empty lines), add \\? to match empty lines too
          }
        end,
        desc = "Flash Jump Line",
      },
    },

    config = function()
      require("flash").setup {
        -- labels = "ASDFGHJKLQWERTYUIOPZXCVBNM",
        label = {
          rainbow = {
            enabled = false,
          },
        },
        highlight = {
          priority = 9900,
        },
        modes = {
          char = {
            -- `f`, `F`, `t`, `T`, `;` and `,` motions
            enabled = true,
            keys = { "f", "F", "t", "T", ";", "," },
            jump_labels = function(motion)
              -- never show jump labels by default
              -- return false
              -- Always show jump labels for ftFT
              return vim.v.count == 0 and motion:find "[ftFT]"
              -- Show jump labels for ftFT in operator-pending mode
              -- return vim.v.count == 0 and motion:find("[ftFT]") and vim.fn.mode(true):find("o")
            end,
          },
        },
      }
      -- local Config = require "flash.config"
      -- local Char = require "flash.plugins.char"
      -- for _, motion in ipairs { "f", "t", "F", "T" } do
      --   vim.keymap.set({ "n", "x", "o" }, motion, function()
      --     require("flash").jump(Config.get({
      --       mode = "char",
      --       search = {
      --         mode = Char.mode(motion),
      --         max_length = 1,
      --       },
      --       highlight = {
      --         label = { rainbow = { enabled = false } },
      --         backdrop = false,
      --       },
      --     }, Char.motions[motion]))
      --   end)
      -- end
    end,
  },
  {
    -- preview line when using goto :xyz
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },
  {
    "axlebedev/footprints",
    config = function()
      -- vim.g.footprintsColor = '#512c4f'
      vim.g.footprintsColor = "#00c0f0"
      vim.g.footprintsOnCurrentLine = 0
      vim.g.footprintsEasingFunction = "easeinout"
      vim.g.footprintsHistoryDepth = 27
    end,
  },
  {
    "tomasky/bookmarks.nvim",
    -- after = "telescope.nvim",
    event = "VimEnter",
    config = function()
      require("bookmarks").setup {
        -- sign_priority = 8,  --set bookmark sign priority to cover other sign
        save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
        keywords = {
          ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
          ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        },
        on_attach = function(bufnr)
          local bm = require "bookmarks"
          local map = vim.keymap.set
          map("n", "mm", bm.bookmark_toggle) -- add or remove bookmark at current line
          map("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
          map("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
          map("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
          map("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
          map("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
          map("n", "mg", function()
            require("telescope").extensions.bookmarks.list()
          end) -- show marked file list in quickfix window
        end,
      }
    end,
  },
  -- {
  --   "MattesGroeger/vim-bookmarks",
  --   config = function()
  --     vim.api.nvim_set_keymap("n", "mn", "<Plug>BookmarkNext | zvzz", { silent = true })
  --     vim.api.nvim_set_keymap("n", "mp", "<Plug>BookmarkPrev | zvzz", { silent = true })
  --   end,
  -- },

  -- ternimal in popup -------------------------------------------------------------------------------------------------------
  {
    "voldikss/vim-floaterm", -- in vimscript - but works with ranger and lazygit and other
    init = function()
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_opener = "edit"
      vim.g.floaterm_borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
      local hl_manager = require "hl_manager"
      hl_manager.highlight_link("FloatermBorder", "Normal")
    end,
  },
  {
    "simonmclean/triptych.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-tree/nvim-web-devicons", -- optional
    },
    config = function()
      require("triptych").setup {}
    end,
  },

  --REPLS -------------------------------------------------------------------------------------------------------
  "rafcamlet/nvim-luapad", -- :Luapad - open interactive scratch bufer with realtime eval
  {
    "metakirby5/codi.vim", -- repls for all other langs ...
    config = function()
      require "nv-codi"
    end,
  },
  {
    "David-Kunz/gen.nvim",
    -- "JoseConseco/gen.nvim", -- my fork
    -- commit = "c3fca8695dd61c350e08e9912784c21061f98a1e", -- later version wont work with llamacpp - seems fixed after all
    config = function()
      require "nv_gen-nvim"
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "iguanacucumber/magazine.nvim", -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
      { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the default Neovim UI
    },
    config = function ()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
          agent = {
            adapter = "copilot",
          },
        },
      })
    end
  },
  {
    "yetone/avante.nvim", -- emulate the behaviour of the Cursor AI IDE: ChatGpt, Copilot, Deepseek etc
    -- commit = "2bab4bf601650eede1a91a53134b406863a8e06b", -- after that  copilot support was removed
    event = "VeryLazy",
    lazy = false,
    opts = {
      -- add any opts here
    },
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end, desc = "avante: ask", mode = { "n", "v" }, },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh", },
      { "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit", mode = "v", },
      { "<leader>as", function() require("avante.api").get_suggestion():suggest() end, desc = "avante: Suggest", mode = "v", },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        -- "HakonHarnes/img-clip.nvim",
        -- event = "VeryLazy",
        -- opts = {
        --   -- recommended settings
        --   default = {
        --     embed_image_as_base64 = false,
        --     prompt_for_file_name = false,
        --     drag_and_drop = {
        --       insert_mode = true,
        --     },
        --     -- required for Windows users
        --     use_absolute_path = true,
        --   },
        -- },
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    config = function()
      require("avante").setup {
        provider = "copilot",
        -- provider = "deepseek", -- noo goooddd
        -- vendors = {
        --   ["deepseek"] = {
        --     endpoint = "https://api.deepseek.com/chat/completions",
        --     model = "deepseek-coder",
        --     api_key_name = "DEEPSEEK_API_KEY",
        --     parse_curl_args = function(opts, code_opts)
        --       return {
        --         url = opts.endpoint,
        --         headers = {
        --           ["Accept"] = "application/json",
        --           ["Content-Type"] = "application/json",
        --           ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
        --         },
        --         body = {
        --           model = opts.model,
        --           messages = require("avante.providers").azure.parse_message(code_opts), -- you can make your own message, but this is very advanced
        --           temperature = 0,
        --           max_tokens = 4096,
        --           stream = true, -- this will be set by default.
        --         },
        --       }
        --     end,
        --     parse_response_data = function(data_stream, event_state, opts)
        --       require("avante.providers").azure.parse_response(data_stream, event_state, opts)
        --     end,
        --   },
        -- },
        hints = { enabled = false },
      }
    end,
  },
  {
    "sphamba/smear-cursor.nvim",
    cond = vim.g.neovide == nil,
    opts = {
      cursor_color = "#ff8800",
      stiffness = 0.6,
      trailing_stiffness = 0.2,
      trailing_exponent = 4,
      -- gamma = 1,
    },
  },
  {
    "rasulomaroff/reactive.nvim", -- detect eg. operator pending mode
    config = function()
      require("reactive").setup {
        builtin = {
          cursorline = false,
          cursor = false,
          modemsg = false,
        },
        configs = {
          -- a key here is a preset name, a value can be a boolean (if false, presets will be disabled)
          -- or a table that overwrites preset's values
          presetone = {
            modes = {},
          },
        },
      }
      require("reactive").add_preset {
        name = "relativenumber",
        modes = {
          no = {
            to = function()
              vim.opt.relativenumber = true
            end,
            from = function()
              vim.opt.relativenumber = false
            end,
            operators = { -- only in no, nov, noV, and no\x16 modes
              d = {
                winhl = { CursorLine = { link = "DiffDelete" } },
              },
              c = {
                winhl = { CursorLine = { link = "DiffText" } },
              },
            },
          },

          i = {
            winhl = {
              CursorLine = { link = "DiffAdd" },
            },
          },
        },
      }
    end,
  },
  ---  TOOLS -------------------------------------------------------------------------------------------------------
}
