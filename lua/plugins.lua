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
    "rmehri01/onenord.nvim",
    enabled = false,
    config = function()
      require("onenord").setup {
        borders = true, -- Split window borders
        italics = { comments = true, strings = false, keywords = true, functions = false, variables = false },
        bold = { comments = false, strings = false, keywords = true, functions = true, variables = false },
        custom_highlights = { Normal = { bg = "#272b2E" } }, -- Overwrite default highlight groups
      }
    end,
  },
  "Mofiqul/adwaita.nvim",
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
    lazy = false, -- loads immediately
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
  "mhartington/oceanic-next",

  -- -- UI -------------------------------------------------------------------------------------------------------
  {
    -- "norcalli/nvim-colorizer.lua",  -- original repo - not maintained
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        filetypes = { "css", "lua", "html" },
      }
    end,
  }, --color highlighter
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
    -- "folke/twilight.nvim",
    "mkonig/twilight.nvim",
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
  -- -- "nvim-tree/nvim-web-devicons",
  -- {
  --   "nvim-tree/nvim-web-devicons",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  --   config = function()
  --     require "web-devicons"
  --   end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require "nv-lualine"
    end,
  },
  {
    "akinsho/nvim-bufferline.lua",
    -- after = "nightfox.nvim",
    cond = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require "nv-bufferline"
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
          Reg = {
            cmd = "norm",
            -- This will transform ":5Reg a" into ":norm 5@a"
            args = function(opts)
              return (opts.count == -1 and "" or opts.count) .. "@" .. opts.args
            end,
            range = "",
          },
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
    "Xuyuanp/scrollbar.nvim",
    enabled = false,
    config = function()
      vim.cmd [[
				augroup ScrollbarInit
				autocmd!
				autocmd WinScrolled,VimResized,QuitPre * silent! lua require('scrollbar').show()
				autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
				autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
				augroup end
			]]
      vim.g.scrollbar_shape = { head = "▎", body = "▎", tail = "▎" }
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
      require("neoscroll").setup { hide_cursor = false }
    end,
  },

  -- WINDOWS MANAGER  -------------------------------------------------------------------------------------------------------
  {
    "beauwilliams/focus.nvim",
    cond = false, -- autoresize windows to gold ration - replaced with "anuvyklack/windows.nvim"
    config = function()
      require("focus").setup {
        enabled = true,
        excluded_filetypes = { "fzf" },
      }
    end,
  },
  {
    "anuvyklack/windows.nvim",
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
        autowidth = {
          winwidth = 0.62,
        },
        ignore = {
          --			  |windows.ignore|
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "DiffviewFiles" },
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
    "sindrets/winshift.nvim",
    config = function()
      require("winshift").setup {
        keymaps = {
          disable_defaults = true,
        },
      }
    end,
  },

  -- DEBUGGING  -------------------------------------------------------------------------------------------------------
  {
    "mfussenegger/nvim-dap", --too simple
    config = function()
      require "dap"
      require "nv-dap"
    end,
  }, -- preview line whe using goto :xyz
  {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "/usr/bin/python"
    end,
  },
  {
    "folke/neodev.nvim",
  },
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
    dependencies = { "mfussenegger/nvim-dap" },
    -- commit = "6b6081ad244ae5aa1358775cc3c08502b04368f9", -- till fix is merged
    config = function()
      require "nv-dapui"
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
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "lsp"
    end,
  }, -- lua + wont close () next to char finally good and simple +++
  {
    "rmagatti/goto-preview",
    config = function()
      require "nv-goto-preview"
    end,
  },
  {
    "SirVer/ultisnips",
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
  -- {
  --   "SmiteshP/nvim-navbuddy",  -- code outline - but without filtering
  --   dependencies = { "neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
  --   config = function()
  --     require("nvim-navbuddy").setup {
  --       lsp = {
  --         auto_attach = true, -- If set to true, you don't need to manually use attach function
  --         preference = nil, -- list of lsp server names in order of preference
  --       },
  --       source_buffer = {
  --         follow_node = false, -- Keep the current node in focus on the source buffer
  --         highlight = false, -- Highlight the currently focused node
  --       },
  --     }
  --   end,
  -- },
  --  {disable=true,
  -- {"ray-x/lsp_signature.nvim" }, --  for funct(), signature hint - replaced with noice

  {
    "ThePrimeagen/refactoring.nvim",
    enabled = true,
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-treesitter/nvim-treesitter" } },
    config = function()
      require "nv-refactoring"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- cond = false,
    config = function()
      require "nv-null"
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
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
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },
  {
    "hrsh7th/nvim-cmp",
    cond = true,
    event = "InsertEnter",
    dependencies = {
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
    },
    config = function()
      require "nv-cmp"
    end,
  },
  { "quangnguyen30192/cmp-nvim-ultisnips", dependencies = { "hrsh7th/nvim-cmp" } },
  { "dmitmel/cmp-cmdline-history", dependencies = "hrsh7th/cmp-cmdline" },
  -- { "tzachar/cmp-fuzzy-path", dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-path", "tzachar/fuzzy.nvim" } }
  -- use { "tzachar/cmp-fuzzy-buffer", dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } }
  {
    "tzachar/cmp-tabnine",
    cond = true,
    event = "InsertEnter",
    dependencies = "hrsh7th/nvim-cmp",
    build = "./install.sh",
    config = function()
      require("cmp_tabnine.config"):setup {
        max_lines = 100,
        max_num_results = 3,
        sort = true,
      }
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
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
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "tom-anders/telescope-vim-bookmarks.nvim", "JoseConseco/telescope_sessions_picker.nvim" },
    cmd = "Telescope frecency",
    config = function()
      require "telescope-nvim"
    end,
  }, -- lua + wont lose () next to char finally good and simple +++
  "nvim-telescope/telescope-media-files.nvim",
  {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require("telescope").load_extension "frecency"
    end,
    dependencies = { "kkharji/sqlite.lua" },
  },
  {
    "debugloop/telescope-undo.nvim",
    cmd = "Telescope undo",
    config = function()
      require("telescope").load_extension "undo"
    end,
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
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("neogit").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {
        keymaps = {
          -- vim-surround style keymaps
          -- insert = "ys",
          visual = "S",
          delete = "ds",
          change = "cs",
        },
      }
    end,
  },
  -- { "tpope/vim-repeat" },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "lewis6991/foldsigns.nvim" },
    config = function()
      require "nv-gitsigns"
    end,
  }, -- lua + wont close () next to char finally good and simple +++
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
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
    "anuvyklack/hydra.nvim",
    dependencies = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
    config = function()
      require "nv-hydra"
    end,
  },
  {
    "folke/todo-comments.nvim", -- original
    config = function()
      require "nv-todo"
    end,
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
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
  -- {
  --   "ecthelionvi/NeoComposer.nvim",
  --   dependencies = { "kkharji/sqlite.lua" },
  --   opts = {
  --     notify = false
  --   },
  -- },

  --find and replace ? -------------------------------------------------------------------------------------------------------
  {
    "kevinhwang91/nvim-bqf", --better quickfix  (with preview and complicated mapping)
    config = function()
      require("bqf").setup {
        auto_enable = true,
        auto_resize_height = true, -- highly recommended enable
        preview = { -- stefandtw/quickfix-reflector.vim breaks this
          auto_preview = true,
        },
        -- create autocmd for 'qf' filetype. It will create 2 buffer levels mappings: for j and k keys.
        -- These keys will send 'pp' keys to refresh the preview window.
      }
    end,
  },
  "stefandtw/quickfix-reflector.vim", -- edit quickfix list as text - :w to save to multi files
  -- 'gabrielpoca/replacer.nvim',   -- edit quick fis list - in lua - not as good as quickfix-reflector
  "brooth/far.vim", --use: Far(r) from to **/*.py   > then :Fardo
  "dyng/ctrlsf.vim", --Run :CtrlSF [pattern]
  "mhinz/vim-grepper", -- Grepper
  "eugen0329/vim-esearch", -- Grepper
  { "windwp/nvim-spectre", dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } },
  {
    "AckslD/muren.nvim",
    config = true,
  },

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
  "wellle/targets.vim", -- eg ci,  ci_ etc replaced by mini.ai
  -- use({ -- select indent lua
  -- 	"arsham/indent-tools.nvim",
  -- 	dependencies = { "arsham/arshlib.nvim" },
  -- 	config = function() require("indent-tools").config({}) end,
  -- })
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
    "andymass/vim-matchup", -- slow as hell
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
    "windwp/nvim-autopairs", -- lua + wont close () next to char finally good and simple +++
    config = function()
      require "nv-autopairs"
    end,
  },

  "JoseConseco/vim-case-change", -- rotate strign case - modded by me
  {
    "johmsalas/text-case.nvim", -- ga then eg. u for upper  case (gau)
    config = function()
      require("textcase").setup {}
    end,
  },
  {
    "mg979/vim-visual-multi", --multi cursor support like vscode...
    config = function()
      vim.g.VM_mouse_mappings = 1
    end,
  },
  {
    "smoka7/multicursors.nvim", -- still n wayto to MC from visual sel
    cond = false,
    event = "VeryLazy",
    opts = {},
    keys = {
      { "<C-n>", "<cmd>MCstart<cr>", desc = "Create a selection for word under the cursor" },
    },
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      require "nv-mini"
    end,
  },
  {
    "danymat/neogen", -- generate code docs
    config = function()
      require("neogen").setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    version = "*",
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
    -- commit="13022c09fa30fb03d14110a380238f6a75b42ab4", -- correct colors under cword
    event = "VeryLazy",
    -- branch = "rainbow",
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
      },
      {
        "R",
        mode = { "o", "x" }, -- remote search (treesitter)
        function()
          require("flash").treesitter_search {
            label = {
              rainbow = {
                enabled = true,
              },
            },
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
    "MattesGroeger/vim-bookmarks",
    config = function()
      vim.api.nvim_set_keymap("n", "mn", "<Plug>BookmarkNext | zvzz", { silent = true })
      vim.api.nvim_set_keymap("n", "mp", "<Plug>BookmarkPrev | zvzz", { silent = true })
    end,
  },

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

  --REPLS -------------------------------------------------------------------------------------------------------
  "rafcamlet/nvim-luapad", -- :Luapad - open interactive scratch bufer with realtime eval
  {
    "metakirby5/codi.vim", -- repls for all other langs ...
    config = function()
      require "nv-codi"
    end,
  },
  {
    "gsuuon/llm.nvim",
    -- "JoseConseco/llm.nvim",
    -- dev = true, -- too keep local changes
    config = function()
      require "nv_llm-nvim"
    end,
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   config = function()
  --     require("chatgpt").setup {
  --       -- optional configuration
  --     }
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },

  ---  TOOLS -------------------------------------------------------------------------------------------------------
  {
    "AckslD/messages.nvim", -- :Messages messages
    config = function()
      require("messages").setup()
    end,
  },
  {
    "SmiteshP/nvim-navic", -- bread_crumbs
    dependencies = "neovim/nvim-lspconfig",
    config = function()
      require("nvim-navic").setup {
        icons = { Class = "⛬ " },
        separator = " ▶ ",
      }
    end,
  },
}
