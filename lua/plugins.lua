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

  -- UI -------------------------------------------------------------------------------------------------------
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
    config = function()
      vim.cmd [[let HiClearUsingOneTime = 1]]
    end,
  },
  {
    -- "folke/twilight.nvim",
    "mkonig/twilight.nvim",
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
  -- "nvim-tree/nvim-web-devicons",
  {
    "nvim-tree/nvim-web-devicons",
    dependencies = "nvim-tree/nvim-web-devicons",
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
    "akinsho/nvim-bufferline.lua",
    -- after = "nightfox.nvim",
    cond = false,
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require "nv-bufferline"
    end,
  },
  { -- cmd line replacer
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
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    -- after = "nightfox.nvim",
    config = function()
      local hl_manager = require "hl_manager"
      hl_manager.highlight_from_src("IndentEven", "Normal", { bg = -6 }) -- reduce contrast by default by -5
      vim.cmd [[highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine]]
      -- hl_manager.highlight_from_src("IndentBlanklineContextChar", "Normal", {action='contrast', factor=-10}) -- reduce contrast by default by -5
      -- vim.cmd [[highlight! link IndentBlanklineContextChar Comment]]
      hl_manager.highlight_link("IndentBlanklineContextChar", "Comment")
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
    -- cond = false,
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
        excluded_filetypes = { "fzf"},
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
        ignore = {				--			  |windows.ignore|
              buftype = { "quickfix" },
              filetype = { "NvimTree", "neo-tree", "undotree", "gundo", "DiffviewFiles" }
           },
        animation = {
          duration = 200, -- ms
        },
      }
    end,
  },
  {
    url="https://gitlab.com/yorickpeterse/nvim-window.git", -- pick window quickly
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
    "folke/neodev.nvim"
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
    "mfussenegger/nvim-treehopper",
    config = function()
      vim.api.nvim_set_keymap("o", "u", ":<C-U>lua require('tsht').nodes()<CR>",
        { noremap = false, silent = true, desc = "TSNode (nvim-treehopper" })
      vim.api.nvim_set_keymap("v", "u", ":lua require('tsht').nodes()<CR>",
        { noremap = true, silent = true, desc = "TSNode (nvim-treehopper" })
    end,
  },
  {
    -- "p00f/nvim-ts-rainbow", -- archived
    "mrjones2014/nvim-ts-rainbow",
    -- dependencies = {"nightfox.nvim", "nvim-treesitter/nvim-treesitter"},
    config = function()
      -- add colorscheme change hook
      local hl_manager = require "hl_manager"
      hl_manager.match_color_to_highlight("#df717a", "@keyword", "rainbowcol1", "foreground")
      hl_manager.match_color_to_highlight("#a3be8c", "@keyword", "rainbowcol2", "foreground")
      hl_manager.match_color_to_highlight("#b48ead", "@keyword", "rainbowcol3", "foreground")
      hl_manager.match_color_to_highlight("#88c0d0", "@keyword", "rainbowcol4", "foreground")
      hl_manager.match_color_to_highlight("#d08770", "@keyword", "rainbowcol5", "foreground")
      hl_manager.match_color_to_highlight("#6ea1ec", "@keyword", "rainbowcol6", "foreground")
      hl_manager.match_color_to_highlight("#ebcb8b", "@keyword", "rainbowcol7", "foreground")
    end,
  },
  "nvim-treesitter/playground",

  -- lsp -------------------------------------------------------------------------------------------------------
  "onsails/lspkind-nvim", -- icons for completion popup
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
  { "williamboman/mason.nvim" },
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
  {
    "SmiteshP/nvim-navbuddy",
    dependencies = { "neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
    config = function()
      require("nvim-navbuddy").setup {
        lsp = {
            auto_attach = true,  -- If set to true, you don't need to manually use attach function
            preference = nil  -- list of lsp server names in order of preference
        },
        source_buffer = {
            follow_node = false,   -- Keep the current node in focus on the source buffer
            highlight = false      -- Highlight the currently focused node
        }
      }
    end,
  },
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
    cond=false,
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      vim.g.copilot_filetypes = { ["dap-repl"] = false }
    end,
  },
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
      "quangnguyen30192/cmp-nvim-ultisnips",
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
  { "dmitmel/cmp-cmdline-history", dependencies = "hrsh7th/cmp-cmdline" },
  -- use { "tzachar/cmp-fuzzy-path", dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-path", "tzachar/fuzzy.nvim" } }
  -- use { "tzachar/cmp-fuzzy-buffer", dependencies = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } }
  {
    "tzachar/cmp-tabnine",
    cond = true,
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
  	"zbirenbaum/copilot.lua", -- alternative in lua
  	event = "InsertEnter",
    cmd = "Copilot",
  	config = function()
      require("copilot").setup({
        suggestion = { enabled = true, auto_trigger=true },
        panel = { enabled = false },
      })
    end,
  },
  {
     "zbirenbaum/copilot-cmp",
     dependencies = {"copilot.lua", "nvim-cmp"},
    config = function ()
      require("copilot_cmp").setup()
    end
  },

  -- Telescope   -------------------------------------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    -- branch = "fix/another_teardown_issue",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-lua/popup.nvim" ,  "nvim-lua/plenary.nvim" , "tom-anders/telescope-vim-bookmarks.nvim",
      "JoseConseco/telescope_sessions_picker.nvim" },
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
    config = function()
      require("telescope").load_extension "undo"
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim", build = "make"
  },

  -- Explorer  -------------------------------------------------------------------------------------------------------
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({

      })
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons'}, -- optional, for file icons },
    config = function()
      require("nvimTree")
    end,
    tag = 'nightly', -- optional, updated every week. (see issue #1193)
  },
  {
    "nvim-neo-tree/neo-tree.nvim",  -- nice buffers preview...
    cond = true,
    branch = "v2.x",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim", },
    config = function()
      require "nv_neotree"
    end
  },
  -- Git  -------------------------------------------------------------------------------------------------------
  {
    "tpope/vim-fugitive", -- add :Gitxx commands
  },
  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup {
        keymaps = { -- vim-surround style keymaps
          -- insert = "ys",
          visual = "S",
          delete = "ds",
          change = "cs",
        },
      }
    end,
  },
  {
    "tpope/vim-repeat",
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "lewis6991/foldsigns.nvim" },
    config = function()
      require "nv-gitsigns"
    end,
  }, -- lua + wont close () next to char finally good and simple +++
  {
    "sindrets/diffview.nvim",
    -- dependencies = "nightfox.nvim",
    cmd = {"DiffviewOpen", "DiffviewFileHistory"},
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
      }
    end,
  },

  -- general  -------------------------------------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    -- branch = "pr/278", -- visual multi fix
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
  -- 'gabrielpoca/replacer.nvim',   -- edit quick fis list - in lua
  "brooth/far.vim", --use: Far(r) from to **/*.py   > then :Fardo
  "dyng/ctrlsf.vim", --Run :CtrlSF [pattern]
  --  use {"JoseConseco/ctrlsf.vim", --Run :CtrlSF [pattern] - fixes dow \r escape
  -- 	-- config = function()
  -- 	-- 	-- vim.g.ctrlsf_debug_mode=1
  -- 	-- end,
  -- }
  "mhinz/vim-grepper", -- Grepper
  "eugen0329/vim-esearch", -- Grepper
  { "windwp/nvim-spectre", dependencies = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } },

  --UNDO REDO  -------------------------------------------------------------------------------------------------------
  {
    "AckslD/nvim-neoclip.lua",
    dependencies = {"nvim-telescope/telescope.nvim"},
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
    enabled = false, -- increase power of % - slow as hell (not any more?) higlights fun, if etc. ranges
    init = function()
      vim.g.matchup_matchparen_deferred = 1
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
  { "johmsalas/text-case.nvim",  -- ga then eg. u for upper  case (gau)
    config = function()
      require('textcase').setup {}
    end
  },
  {
    "mg979/vim-visual-multi", --multi cursor support like vscode...
    config = function()
      vim.g.VM_mouse_mappings = 1
    end,
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
  { -- increse decrease numbers but also datas, true to false etc
    "monaqa/dial.nvim",
    config = function()
      require "nv-dial"
    end,
  },

  -- navigation  -------------------------------------------------------------------------------------------------------
  {
    "rlane/pounce.nvim",
    config = function()
      require("pounce").setup {
        accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
        accept_best_key = "<enter>",
        multi_window = false,
        debug = false,
      }
      vim.api.nvim_set_keymap("n", "  ", ":Pounce<cr>", { noremap = true, desc = "Pounce", silent = true })
      vim.api.nvim_set_keymap("v", "  ", "<cmd>Pounce<cr>", { noremap = true, desc = "Pounce", silent = true })
      vim.api.nvim_set_keymap("o", "  ", "<cmd>Pounce<cr>", { noremap = true, desc = "Pounce", silent = true })
    end,
  },
  {
    "phaazon/hop.nvim",
    -- branch = "fix-pending-operation-col-increment",
    config = function()
      require("hop").setup {}
      vim.api.nvim_set_keymap("o", "h", ":HopChar1<cr>", { noremap = true })
      -- vim.api.nvim_set_keymap("n", "  ", ":HopChar2<cr>", { noremap = true })
      -- vim.api.nvim_set_keymap("v", "  ", "<cmd>HopWord<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "gl", ":HopLineStart<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "gw", ":HopChar2<cr>", { noremap = true })
      vim.api.nvim_set_keymap("v", "gl", "<cmd>HopLineStart<cr>", { noremap = true })
      vim.api.nvim_set_keymap("v", "gw", "<cmd>HopChar2<cr>", { noremap = true })

      local modes = { "n", "v", "o" }
      for _, mode in ipairs(modes) do
        vim.api.nvim_set_keymap(mode, "f",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset=0})<cr>"
          , {})
        vim.api.nvim_set_keymap(mode, "F",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset=0})<cr>"
          , {})
        vim.api.nvim_set_keymap(mode, "t",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>"
          , {})
        vim.api.nvim_set_keymap(mode, "T",
          "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>"
          , {})
      end
    end,
  },
  { -- preview line when using goto :xyz
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
    config = function() require("nv-codi") end,
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
    config = function ()
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
