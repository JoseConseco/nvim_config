-- check if packer is installed (~/local/share/nvim/site/pack)
-- local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- vim.cmd [[packadd packer.nvim]]
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.api.nvim_command "packadd packer.nvim"
end

-- vim.cmd [[
-- augroup packer_user_config
--   autocmd!
--   autocmd BufWritePost plugins.lua source <afile> | PackerCompile
-- augroup end]]

-- Auto compile when there are changes in plugins.lua
require("packer").init {
  git = {
    clone_timeout = 20,
  },
}

-- use {
--   'myusername/example',        -- The plugin location string
--   -- The following keys are all optional
--   disable = boolean,           -- Mark a plugin as inactive
--   as = string,                 -- Specifies an alias under which to install the plugin
--   installer = function,        -- Specifies custom installer. See "custom installers" below.
--   updater = function,          -- Specifies custom updater. See "custom installers" below.
--   after = string or list,      -- Specifies plugins to load before this plugin. See "sequencing" below
--   rtp = string,                -- Specifies a subdirectory of the plugin to add to runtimepath.
--   opt = boolean,               -- Manually marks a plugin as optional.
--   branch = string,             -- Specifies a git branch to use
--   tag = string,                -- Specifies a git tag to use
--   commit = string,             -- Specifies a git commit to use
--   lock = boolean,              -- Skip this plugin in updates/syncs
--   run = string or function,    -- Post-update/install hook. See "update/install hooks".
--   requires = string or list,   -- Specifies plugin dependencies. See "dependencies".
--   rocks = string or list,      -- Specifies Luarocks dependencies for the plugin
--   config = string or function, -- Specifies code to run after this plugin is loaded.
--   -- The setup key implies opt = true
--   setup = string or function,  -- Specifies code to run before this plugin is loaded.
--   -- The following keys all imply lazy-loading and imply opt = true
--   cmd = string or list,        -- Specifies commands which load this plugin.
--   ft = string or list,         -- Specifies filetypes which load this plugin.
--   keys = string or list,       -- Specifies maps which load this plugin. See "Keybindings".
--   event = string or list,      -- Specifies autocommand events which load this plugin.
--   fn = string or list          -- Specifies functions which load this plugin.
--   cond = string, function, or list of strings/functions,   -- Specifies a conditional test to load this plugin
--   module = string or list      -- Specifies Lua module names for require. When requiring a string which starts
--                                -- with one of these module names, the plugin will be loaded.
-- }
-- packadd - edge theme delayed?

return require("packer").startup(function(use)
  use { "wbthomason/packer.nvim" } -- Packer can manage itself as an optional plugin

  use "nvim-lua/plenary.nvim"

  -- THEMES -------------------------------------------------------------------------------------------------------
  use "mvpopuk/inspired-github.vim"
  use "ful1e5/onedark.nvim"
  use {
    "rmehri01/onenord.nvim",
    disable = true,
    config = function()
      require("onenord").setup {
        borders = true, -- Split window borders
        italics = { comments = true, strings = false, keywords = true, functions = false, variables = false },
        bold = { comments = false, strings = false, keywords = true, functions = true, variables = false },
        custom_highlights = { Normal = { bg = "#272b2E" } }, -- Overwrite default highlight groups
      }
    end,
  }
  use "Mofiqul/adwaita.nvim"
  use {
    "projekt0n/github-nvim-theme",
    config = function()
      --require("github-theme").setup {
      -- 	theme_style = "light",
      -- 	colors = {bg = "#f5f5f5"},
      -- 	keyword_style = "bold",
      -- 	comment_style = "italic",
      -- }
    end,
  }
  use {
    "EdenEast/nightfox.nvim",
    -- branch = "feat/interactive",
    config = function()
      require "nv-nightfox"
    end,
  }
  use {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim",
  }
  use {
    "m-demare/hlargs.nvim",
    after = "nightfox.nvim",
    config = function()
      local palette = require("nightfox.palette").load "nightfox"
      require("hlargs").setup {
        color = palette.cyan.bright, -- color of 'ident' - how ot make it work for all themes?
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
      hl_manager.highlight_link("Hlargs", "TSParameter")
    end,
  }

  use {
    "folke/tokyonight.nvim",
    setup = function()
      require "themes.tokyonight"
    end,
    -- config=function() vim.cmd('colorscheme tokyonight'); vim.cmd([[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]])end
  } -- lua + wont close () next to char finally good and simple +++
  use "mhartington/oceanic-next"

  -- UI -------------------------------------------------------------------------------------------------------
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  } --color highlighter
  use "kyazdani42/nvim-web-devicons"
  use {
    "ryanoasis/vim-devicons",
    config = function()
      require "web-devicons"
    end,
  } -- lua + wont close () next to char finally good and simple +++
  use {
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require "nv-lualine"
    end, -- lua + wont close () next to char finally good and simple +++
  }
  use {
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("bufferline").setup()
      require "nv-bufferline"
    end,
  }
  use {
    "lukas-reineke/indent-blankline.nvim",
    after = "nightfox.nvim",
    config = function()
      local hl_manager = require "hl_manager"
      hl_manager.highlight_from_src("IndentEven", "Normal", { action = "contrast", factor = -6 }) -- reduce contrast by default by -5
      vim.cmd [[highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine]]
      -- hl_manager.highlight_from_src("IndentBlanklineContextChar", "Normal", {action='contrast', factor=-10}) -- reduce contrast by default by -5
      -- vim.cmd [[highlight! link IndentBlanklineContextChar Comment]]
      hl_manager.highlight_link("IndentBlanklineContextChar", "Comment")
      require "nv-indentline"
    end,
  }
  use {
    "Xuyuanp/scrollbar.nvim",
    disable = true, -- side scrollbar  -fucks up session load often :/ - but at least wont break tele
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
  }

  use {
    "petertriho/nvim-scrollbar",
    cond = true, -- scrollbar which shows search resutls   and errors
    config = function()
      require("scrollbar").setup {
        handle = {
          text = " ",
          color = "#507990",
          hide_if_all_visible = true, -- Hides handle if all lines are visible
        },
        marks = {
          Search = { text = { "━", "𝝣" }, priority = 0, color = "orange" },
          Error = { text = { "━", "𝝣" }, priority = 1, color = "red" },
          Warn = { text = { "━", "𝝣" }, priority = 2, color = "yellow" },
          Info = { text = { "-", "=" }, priority = 3, color = "blue" },
          Hint = { text = { "-", "=" }, priority = 4, color = "green" },
          Misc = { text = { "-", "=" }, priority = 5, color = "purple" },
        },
      }
    end,
  }
  use {
    "kevinhwang91/nvim-hlslens",
    after = "nvim-scrollbar",
    config = function()
      require("scrollbar.handlers.search").setup {
        nearest_only = true,
        calm_down = false,
        -- override_lens = function() end,
      }
      -- set at bottom of keymaps
      -- local kopts = {noremap = true, silent = true}
      -- vim.api.nvim_set_keymap('n', 'n',
      -- 		[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
      -- vim.api.nvim_set_keymap('n', 'N',
      -- 		[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
    end,
  }

  --	config=function() require("nv-scrollbar")  end } -- preview line whe using goto :xyz
  use {
    "dstein64/nvim-scrollview",
    disable = true, -- broken since one or two weeks- box covers in tele input
    config = function()
      vim.api.nvim_exec("highlight link ScrollView Normal", false)
      vim.g.scrollview_character = "▎"
      vim.g.scrollview_excluded_filetypes = { "telescope" }
      vim.g.scrollview_hide_on_intersect = true
    end,
  }
  -- use {'machakann/vim-highlightedyank',
  --	config=function() vim.g.highlightedyank_highlight_duration = 100 end}

  -- WINDOWS MANAGE  -------------------------------------------------------------------------------------------------------
  use {
    "beauwilliams/focus.nvim",
    disable = false, -- autoresize windows to gold ration - brokens with scroll
    config = function()
      require("focus").setup { enable = true }
    end,
  }
  use {
    "https://gitlab.com/yorickpeterse/nvim-window.git", -- pick window quickly
    config = function()
      vim.api.nvim_set_keymap("n", "<c-w>w", ":lua require('nvim-window').pick()<CR>", { noremap = true, silent = true })
    end,
  }

  -- DEBUGGING  -------------------------------------------------------------------------------------------------------
  use {
    "mfussenegger/nvim-dap", --too simple
    config = function()
      require "dap"
      require "nv-dap"
    end,
  } -- preview line whe using goto :xyz
  use {
    "mfussenegger/nvim-dap-python",
    config = function()
      require("dap-python").setup "/usr/bin/python"
    end,
  }
  use {
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
  }
  use {
    "theHamsta/nvim-dap-virtual-text",
    requires = "mfussenegger/nvim-dap",
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
  }
  use {
    "rcarriga/nvim-dap-ui",
    requires = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  }

  -- Treesitter    -------------------------------------------------------------------------------------------------------
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require "treesitter"
    end,
  }
  use {
    "romgrk/nvim-treesitter-context",
    cond = true, -- cool but gives orror on compe-popup - https://github.com/romgrk/nvim-treesitter-context/issues/49
    config = function()
      require "nv-treesittercontext"
    end,
  } -- fixes plug  }
  -- use {"mizlan/iswap.nvim",
  use {
    "JoseConseco/iswap.nvim",
    config = function()
      require("iswap").setup {
        hl_snipe = "ErrorMsg",
        autoswap = true,
        hl_selection = "",
      }
    end,
  }
  use {
    "mfussenegger/nvim-ts-hint-textobject",
    config = function()
      vim.api.nvim_set_keymap("o", "u", ":<C-U>lua require('tsht').nodes()<CR>", { noremap = false, silent = true })
      vim.api.nvim_set_keymap("v", "u", ":lua require('tsht').nodes()<CR>", { noremap = true, silent = true })
    end,
  }
  use {
    "p00f/nvim-ts-rainbow",
    after = "nightfox.nvim",
    config = function()
      -- add colorscheme change hook
      local hl_manager = require "hl_manager"
      hl_manager.match_color_to_highlight("#ebcb8b", "TSPunctBracket", "rainbowcol1", "fg")
      hl_manager.match_color_to_highlight("#a3be8c", "TSPunctBracket", "rainbowcol2", "fg")
      hl_manager.match_color_to_highlight("#88c0d0", "TSPunctBracket", "rainbowcol3", "fg")
      hl_manager.match_color_to_highlight("#6ea1ec", "TSPunctBracket", "rainbowcol4", "fg")
      hl_manager.match_color_to_highlight("#b48ead", "TSPunctBracket", "rainbowcol5", "fg")
      hl_manager.match_color_to_highlight("#df717a", "TSPunctBracket", "rainbowcol6", "fg")
      hl_manager.match_color_to_highlight("#d08770", "TSPunctBracket", "rainbowcol7", "fg")
    end,
  }
  use "nvim-treesitter/playground"
  use {
    "lewis6991/spellsitter.nvim", -- nicer highlights for spellcheck
    config = function() require("spellsitter").setup() end,
  }

  -- lsp -------------------------------------------------------------------------------------------------------
  use "onsails/lspkind-nvim" -- icons for completion popup
  use {
    "rmagatti/goto-preview", -- eg show preview directly in editable popup
    disable = true,
    config = function()
      require("goto-preview").setup { default_mappings = true }
    end,
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require "lsp"
    end,
  } -- lua + wont close () next to char finally good and simple +++
  use {
    "SirVer/ultisnips",
    disable = false, --  requires='honza/vim-snippets'
    config = function()
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
      vim.cmd [[autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets]]
    end,
  }
  use {
    "stevearc/aerial.nvim",  -- basically better outliner with objects type filter
    config = function() require "nv-aerial" end,
  }
  use { "ray-x/lsp_signature.nvim" } -- used for funct() signature hint
  use {
    "ThePrimeagen/refactoring.nvim",
    disable = false,
    requires = { { "nvim-lua/plenary.nvim" }, { "nvim-treesitter/nvim-treesitter" } },
    config = function()
      require "nv-refactoring"
    end,
  }
  use {
    "jose-elias-alvarez/null-ls.nvim",
    -- cond = false,
    config = function()
      require "nv-null"
    end,
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- AUTO-COMPLETE -------------------------------------------------------------------------------------------------------
  use {
    "github/copilot.vim",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
    end,
  }
  use {
    "hrsh7th/nvim-cmp",
    disable = false,
    requires = {
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
  }
  use { "dmitmel/cmp-cmdline-history", requires = "hrsh7th/cmp-cmdline" }
  -- use { "tzachar/cmp-fuzzy-path", requires = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-path", "tzachar/fuzzy.nvim" } }
  -- use { "tzachar/cmp-fuzzy-buffer", requires = { "hrsh7th/nvim-cmp", "tzachar/fuzzy.nvim" } }
  use {
    "tzachar/cmp-tabnine",
    requires = "hrsh7th/nvim-cmp",
    run = "./install.sh",
    disable = false,
    config = function()
      require("cmp_tabnine.config"):setup {
        max_lines = 100,
        max_num_results = 3,
        sort = true,
      }
    end,
  }
  --  use{
  -- 	"zbirenbaum/copilot.lua", -- alternative in lua
  -- 	event = {"VimEnter"},
  -- 	config = function()
  -- 		vim.defer_fn(function()
  -- 			require("copilot").setup()
  -- 		end, 100)
  -- 	end,
  -- }
  -- use {
  --    "zbirenbaum/copilot-cmp",
  --    after = {"copilot.lua", "nvim-cmp"},
  -- }

  -- Telescope   -------------------------------------------------------------------------------------------------------
  use {
    "nvim-telescope/telescope.nvim",
    -- branch = "fix/another_teardown_issue",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" }, { "tom-anders/telescope-vim-bookmarks.nvim" }, "nvim-telescope/telescope-file-browser.nvim", "JoseConseco/telescope_sessions_picker.nvim" },
    config = function()
      require "telescope-nvim"
    end,
  } -- lua + wont lose () next to char finally good and simple +++
  use "nvim-telescope/telescope-media-files.nvim"
  use {
    "nvim-telescope/telescope-smart-history.nvim", -- per project history
    requires = { "tami5/sqlite.lua" },
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

  -- Explorer  -------------------------------------------------------------------------------------------------------
  use { "elihunter173/dirbuf.nvim" } -- edit dir as buffer text

  -- Git  -------------------------------------------------------------------------------------------------------
  use {
    "tpope/vim-fugitive", -- add :Gitxx commands
  }
  use {
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim", "lewis6991/foldsigns.nvim" },
    config = function()
      require "nv-gitsigns"
    end,
  } -- lua + wont close () next to char finally good and simple +++
  use {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup {}
    end,
  }

  -- general  -------------------------------------------------------------------------------------------------------
  use {
    "folke/which-key.nvim",
    branch = "pr/278",
    after = "plenary.nvim",
    config = function()
      require "nv-which-key"
    end,
  }
  use {
    "folke/todo-comments.nvim",
    config = function()
      require "nv-todo"
    end,
  }
  use {
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
  }

  --find and replace ? -------------------------------------------------------------------------------------------------------
  use "kevinhwang91/nvim-bqf" --better quickfix  (with preview and complicated mapping)
  use "brooth/far.vim" --use: Far(r) from to **/*.py   > then :Fardo
  use "dyng/ctrlsf.vim" --Run :CtrlSF [pattern]
  use "mhinz/vim-grepper" -- Grepper
  use "eugen0329/vim-esearch" -- Grepper
  use { "windwp/nvim-spectre", requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } } }

  --UNDO REDO  -------------------------------------------------------------------------------------------------------
  use {
    "AckslD/nvim-neoclip.lua",
    after = "telescope.nvim",
    config = function()
      require "nv-neoclip"
    end,
  }
  use "mbbill/undotree" -- undo history  :UndotreeToggle to toggle the undo-tree panel.
  use "mg979/vim-localhistory" -- local history LHLoad, LHWrite

  --CODE/FORMAT -------------------------------------------------------------------------------------------------------
  use "wellle/targets.vim" -- eg ci,  ci_ etc
  use {
    "andymass/vim-matchup",
    disable = true, -- increase power of % - slow as hell (not any more?) higlights fun, if etc. ranges
    setup = function()
      vim.g.matchup_matchparen_deferred = 1
    end,
    config = function()
      vim.g.matchup_matchparen_deferred = 1
    end,
  }
  use {
    "monkoose/matchparen.nvim",
    disable = true, -- what idt does? - faster highlight (), [], & {} compared to vim builtin matchparen
    config = function()
      vim.g.loaded_matchparen = 1
      require("matchparen").setup()
    end,
  }

  -- use {'Chiel92/vim-autoformat', -- replaced by null-ls
  -- 	config=function() require('nv-autoformat') end }
  use {
    "windwp/nvim-autopairs", -- lua + wont close () next to char finally good and simple +++
    config = function()
      require "nv-autopairs"
    end,
  }

  use "JoseConseco/vim-case-change" -- rotate strign case - modded by me
  use {
    "mg979/vim-visual-multi", --multi cursor support like vscode...
    config = function()
      vim.g.VM_mouse_mappings = 1
      vim.cmd [[
				aug VMlens
						au!
						au User visual_multi_start lua require('vmlens').start()
						au User visual_multi_exit lua require('vmlens').exit()
				aug END
			]]
    end,
  }
  use {
    "echasnovski/mini.nvim",
    config = function()
      require "nv-mini"
    end,
  }
  use {
    "danymat/neogen", -- generate code docs
    config = function()
      require("neogen").setup {}
    end,
    requires = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    tag = "*",
  }
  use { -- increse decrease numbers but also datas, true to false etc
    "monaqa/dial.nvim",
    config = function()
			require "nv-dial"
    end,
  }

  -- navigation  -------------------------------------------------------------------------------------------------------
	use {'rlane/pounce.nvim',
		 require'pounce'.setup{
			accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
			accept_best_key = "<enter>",
			multi_window = false,
			debug = false,
		},
    config = function()
      vim.api.nvim_set_keymap("n", "  ", ":Pounce<cr>", { noremap = true, desc = "Pounce" })
      vim.api.nvim_set_keymap("v", "  ", "<cmd>Pounce<cr>", { noremap = true, desc = "Pounce" })
      vim.api.nvim_set_keymap("o", "  ", "<cmd>Pounce<cr>", { noremap = true, desc = "Pounce" })
		end

	}
  use {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup {}
      vim.api.nvim_set_keymap("o", "h", ":HopChar1<cr>", { noremap = true })
      -- vim.api.nvim_set_keymap("n", "  ", ":HopWord<cr>", { noremap = true })
      -- vim.api.nvim_set_keymap("v", "  ", "<cmd>HopWord<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "gl", ":HopLineStart<cr>", { noremap = true })
      vim.api.nvim_set_keymap("n", "gw", ":HopWord<cr>", { noremap = true })
      vim.api.nvim_set_keymap("v", "gl", "<cmd>HopLineStart<cr>", { noremap = true })
      vim.api.nvim_set_keymap("v", "gw", "<cmd>HopWord<cr>", { noremap = true })

      vim.api.nvim_set_keymap("n", "f", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap("n", "F", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap("n", "t", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
      vim.api.nvim_set_keymap("n", "T", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})

      vim.api.nvim_set_keymap("v", "f", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap("v", "F", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap("v", "t", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
      vim.api.nvim_set_keymap("v", "T", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})

      vim.api.nvim_set_keymap("o", "f", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap("o", "F", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
      vim.api.nvim_set_keymap("o", "t", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
      vim.api.nvim_set_keymap("o", "T", "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
    end,
  }
  use {
    "karb94/neoscroll.nvim", -- smooth scroll
    config = function()
      require("neoscroll").setup { hide_cursor = false }
    end,
  } -- lua + wont close () next to char finally good and simple +++
  use {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  } -- preview line whe using goto :xyz
  use {
    "axlebedev/footprints",
    config = function()
      -- vim.g.footprintsColor = '#512c4f'
      vim.g.footprintsColor = "#00c0f0"
      vim.g.footprintsOnCurrentLine = 0
      vim.g.footprintsEasingFunction = "linear"
      vim.g.footprintsHistoryDepth = 27
    end,
  }

  use {
    "MattesGroeger/vim-bookmarks",
    config = function()
      vim.api.nvim_set_keymap("n", "mn", "<Plug>BookmarkNext | zvzz", { silent = true })
      vim.api.nvim_set_keymap("n", "mp", "<Plug>BookmarkPrev | zvzz", { silent = true })
    end,
  }

  -- ternimal in popup -------------------------------------------------------------------------------------------------------
  use {
    "voldikss/vim-floaterm", -- in vimscript - but works with ranger and lazygit and other
    setup = function()
      vim.g.floaterm_height = 0.9
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_opener = "edit"
      vim.g.floaterm_borderchars = { " ", " ", " ", " ", " ", " ", " ", " " }
      local hl_manager = require "hl_manager"
      hl_manager.highlight_link("FloatermBorder", "Normal")
    end,
  }
  -- use {
  --   "akinsho/nvim-toggleterm.lua", -- in lua but doew not work with ranger
  --   config = function()
  --     require("toggleterm").setup {}
  --     local Terminal = require("toggleterm.terminal").Terminal
  --     local lazygit = Terminal:new { cmd = "lazygit", hidden = true, direction = "float" }
  --
  --     function _G.lazygit_toggle()
  --       lazygit:toggle()
  --     end
  --   end,
  -- }

  --REPLS -------------------------------------------------------------------------------------------------------
  use "rafcamlet/nvim-luapad" -- :Luapad - open interactive scratch bufer with realtime eval
  use "metakirby5/codi.vim" -- repls for all other langs ...


  ---  TOOLS -------------------------------------------------------------------------------------------------------
  use "rcarriga/nvim-notify"
  use {
    "SmiteshP/nvim-gps", -- bread_crumbs
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-gps").setup {
        icons = { ["class-name"] = "⛬ " },
        separator = " ▶ ",
      }
    end,
  }
end)
