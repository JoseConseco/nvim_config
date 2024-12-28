local function is_dap_buffer()
  return require("cmp_dap").is_dap_buffer()
end

local blink_compact = {
  "saghen/blink.compat",
  version = "*",
  lazy = true,
  opts = {},
}

local blink_cmp = {
  "saghen/blink.cmp",
  dependencies = {
    -- "rafamadriz/friendly-snippets",
    -- "onsails/lspkind.nvim",
    "rcarriga/cmp-dap",
    "JoseConseco/cmp-ai",
  },
  version = "*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      -- nerd_font_variant = "mono",
    },

    completion = {
      accept = { auto_brackets = { enabled = true } },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
        treesitter_highlighting = true,
        window = { border = "rounded" },
      },

      -- list = {
      --   selection = function(ctx)
      --     return ctx.mode == "cmdline" and "auto_insert" or "preselect"
      --   end,
      -- },
      --
      menu = {
        border = "rounded",

        cmdline_position = function()
          if vim.g.ui_cmdline_pos ~= nil then
            local pos = vim.g.ui_cmdline_pos -- (1, 0)-indexed
            return { pos[1] - 1, pos[2] }
          end
          local height = (vim.o.cmdheight == 0) and 1 or vim.o.cmdheight
          return { vim.o.lines - height, 0 }
        end,

        draw = {
          columns = {
            { "kind_icon", "label", gap = 1 },
            { "kind" },
          },
          components = {
            kind_icon = {
              text = function(item)
                local kind = require("lspkind").symbol_map[item.kind] or ""
                return kind .. " "
              end,
              highlight = "CmpItemKind",
            },
            label = {
              text = function(item)
                return item.label
              end,
              highlight = "CmpItemAbbr",
            },
            kind = {
              text = function(item)
                return item.kind
              end,
              highlight = "CmpItemKind",
            },
          },
        },
      },
    },

    -- My super-TAB configuration
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = {
        function(cmp)
          return cmp.select_next()
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = {
        function(cmp)
          return cmp.select_prev()
        end,
        "snippet_backward",
        "fallback",
      },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-up>"] = { "scroll_documentation_up", "fallback" },
      ["<C-down>"] = { "scroll_documentation_down", "fallback" },
    },

    -- Experimental signature help support
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },
    enabled = function()
      return vim.bo.buftype ~= "prompt" or is_dap_buffer()
    end,

    sources = {
      default = { "lsp", "path", "snippets", "buffer" , "dap", "cmp_ai"},
      -- default = function(_)
      --   if is_dap_buffer() then
      --     return { "dap", "buffer" }
      --   else
      --     return { "lsp", "path", "snippets", "buffer" }
      --   end
      -- end,
      cmdline = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands
        if type == ":" then
          return { "cmdline" }
        end
        return {}
      end,
      providers = {
        lsp = {
          min_keyword_length = 2, -- Number of characters to trigger porvider
          score_offset = 0, -- Boost/penalize the score of the items
        },
        path = {
          min_keyword_length = 0,
        },
        snippets = {
          min_keyword_length = 2,
        },
        dap = {
          name = "dap",
          module = "blink.compat.source",
          enabled = function()
            return require("cmp_dap").is_dap_buffer()
          end,
        },
        cmp_ai = {
          name = "cmp_ai",
          module = "blink.compat.source",
          opts = {

            max_lines = 30,
            provider = "DocileLlamaCpp", -- my local LlamaCpp forvading server (will auto start different models)
            provider_options = {
              -- prompt="<｜fim▁begin｜>"..lines_before.."<｜fim▁hole｜>"..lines_after.."<｜fim▁end｜>"
              options = {
                temperature = 0.1,
                n_predict = 35,  -- number of generated predictions
                ['min-p'] = 0.1, -- default 0.05,  Cut off predictions with probability below  Max_prob * min_p
                -- repeat_last_n = 64, -- default 64
                -- repeat_penalty = 1.100, -- default 1.1


                -- new args for my forwarding my python server  branch.. ---------------
                -- model = "CodeQwen1.5-7B-Q4_K_S.gguf", -- still best?
                -- model = "Qwen2.5-Coder-7B-Instruct-Q5_K_S", -- last's best with FIM and instruct at same time
                model = "Qwen2.5.1-Coder-7B-Instruct-Q5_K_M", -- is at as good as 2.5?
                -- cache_prompt= true, -- is necessary for llama.cpp to use the draft model -not..
                -- md = "Qwen2.5.1-Coder-1.5B-Instruct-Q6_K.gguf", -- draft model: at 1.5 size and bigger - questionabel speedup
                md = "Qwen2.5-Coder-0.5B-Instruct-Q6_K.gguf", -- draft model: at 0.5 size and bigger - nicer speedup
                ngl = 50,
                -- draft_min_p = 0.1,
              },
              prompt = function(lines_before, lines_after)
                return '<|fim_prefix|>' .. lines_before .. '<|fim_suffix|>' .. lines_after .. '<|fim_middle|>' -- CodeQwen1

                -- codegeex4-all-9b-Q4_K_M - not so good
                -- local upper_first_ft = vim.bo.filetype:gsub('^%l', string.upper)
                -- local file_name = vim.fn.expand "%:t"
                -- return '<|user|>\n###PATH:'..file_name..'\n###LANGUAGE:'.. upper_first_ft ..'\n###MODE:LINE\n<|code_suffix|>' .. lines_after .. '<|code_prefix|>' .. lines_before .. '<|code_middle|><|assistant|>\n' -- codegeex4-all-9b-Q4_K_M

                -- return "<s><｜fim▁begin｜>" .. lines_before .. "<｜fim▁hole｜>" .. lines_after .. "<｜fim▁end｜>" -- for deepseek coder
                -- return "<fim_prefix>" .. lines_before .. "<fim_suffix>" .. lines_after .. "<fim_middle>" -- for Refact 1.5 coder -- stopped workign after llama update..
              end,
            },
            debounce_delay = 600, -- ms
            notify = true,
            notify_callback = function(msg)
              print(msg)
              -- vim.notify(msg)
            end,
            run_on_every_keystroke = false,
            ignored_file_types = {
              -- default is not to ignore
              -- uncomment to ignore in lua:
              -- lua = true
              -- markdown = true,
            },
          }
          -- enabled = function()
          --   return require("cmp_ai").is_ai_buffer()
          -- end,
        },
        buffer = {
          min_keyword_length = 3,
          max_items = 5,
        },
      },
    },
  },
}
local M = {}
table.insert(M, blink_compact)
table.insert(M, blink_cmp)
return M
