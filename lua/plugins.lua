-- check if packer is installed (~/local/share/nvim/site/pack)
-- local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- vim.cmd [[packadd packer.nvim]]
local install_path = vim.fn.stdpath('data') ..  '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
	vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua
require("packer").init({
	git = {
		clone_timeout=100,
	},
})

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
return require("packer").startup(
	function(use)
		use {"wbthomason/packer.nvim"} -- Packer can manage itself as an optional plugin

		-- themes
		-- use 'joshdick/onedark.vim'
		use 'ful1e5/onedark.nvim'
		use {'projekt0n/github-nvim-theme'}
		-- config = function() require('github-theme').setup({themeStyle='dimmed', keywordStyle="bold"}) end;}
		use {'EdenEast/nightfox.nvim',
			config=function()
				local nightfox = require('nightfox')
				nightfox.setup({
					colors = { red="#dc6959", orange_br="#e49464"},
					styles={keywords = "bold", functions="bold"}
				})
				require('nightfox').load()
				vim.cmd([[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]])
				vim.cmd([[ hi ActiveWindow guibg=#182534
				hi InactiveWindow guibg=#242a39
				set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow]])
			end,}
		use {'folke/tokyonight.nvim',
			setup=function() require('themes.tokyonight'); end,
			-- config=function() vim.cmd('colorscheme tokyonight'); vim.cmd([[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]])end
		} -- lua + wont close () next to char finally good and simple +++
		use 'mhartington/oceanic-next'


		-- UI
		use {'norcalli/nvim-colorizer.lua',
			config=function() require('colorizer').setup() end}  --color highlighter
		use "kyazdani42/nvim-web-devicons"
		use {"ryanoasis/vim-devicons",
			config=function() require("web-devicons") end} -- lua + wont close () next to char finally good and simple +++
		use {'glepnir/galaxyline.nvim', disable=false, --status line and bufferline
			requires = {'kyazdani42/nvim-web-devicons'},
			config=function() require("nv-galaxyline") end} -- lua + wont close () next to char finally good and simple +++
		use {'akinsho/nvim-bufferline.lua',
			requires = 'kyazdani42/nvim-web-devicons',
			config = function() require'bufferline'.setup(); require('nv-bufferline') end }
		use {'lukas-reineke/indent-blankline.nvim', after='tokyonight.nvim', disable=false,--  displaying thin vertical lines at each indentation level
			setup=function() require('nv-indentline') end,
			config=function() vim.cmd([[highlight! link IndentBlanklineContextChar Comment]])  end} -- preview line whe using goto :xyz
		-- use {'Xuyuanp/scrollbar.nvim', -- side scrollbar  -fucks up session load often :/
		--	config=function() require("nv-scrollbar")  end } -- preview line whe using goto :xyz
		use {'dstein64/nvim-scrollview', disable=true,  -- broken since one or two weeks
			config=function()  vim.api.nvim_exec('highlight link ScrollView Normal', false); vim.g.scrollview_character = '▎'
				vim.g.scrollview_excluded_filetypes = {'telescope'}; vim.g.scrollview_hide_on_intersect = true; end}
		use {'machakann/vim-highlightedyank',
			config=function() vim.g.highlightedyank_highlight_duration = 100 end}
		use {'beauwilliams/focus.nvim', disable=true,  -- autoresize windows to gold ration - brokens with scroll
			config = function() require("focus").setup({
				enable = true, cursorline = false, signcolumn = false, hybridnumber = false,
				excluded_filetypes = {"toggleterm", "telescope"},
				excluded_buftypes = {"help", "telescope"},
			})  end}
		use {'https://gitlab.com/yorickpeterse/nvim-window.git',  -- pick window quickly
			config = function() vim.api.nvim_set_keymap('n', '<c-w>w', ":lua require('nvim-window').pick()<CR>", {noremap = true, silent = true}) end}



		-- Debugging
		use {'mfussenegger/nvim-dap', --too simple
			config=function() require('dap'); require('nv-dap') end } -- preview line whe using goto :xyz
		use {'mfussenegger/nvim-dap-python',
			config=function() require('dap-python').setup('/usr/bin/python') end}
		use {'jbyuki/one-small-step-for-vimkind',
			config=function()
				local dap = require"dap"
				dap.configurations.lua = {
					{
						type = 'nlua',
						request = 'attach',
						name = "Attach to running Neovim instance",
						host = function()
							local value = vim.fn.input('Host [127.0.0.1]: ')
							if value ~= "" then
								return value
							end
							return '127.0.0.1'
						end,
						port = function()
							local val = tonumber(vim.fn.input('Port: '))
							assert(val, "Please provide a port number")
							return val
						end,
					}
				}

				dap.adapters.nlua = function(callback, config)
					callback({ type = 'server', host = config.host, port = config.port  or 8088})
				end
			end}
		use {'theHamsta/nvim-dap-virtual-text', requires='mfussenegger/nvim-dap',
			config=function() vim.cmd([[:highlight NvimDapVirtualText guifg=#c296a9]]) end}
		use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'},
			config = function()
				require("dapui").setup()
				local dap, dapui = require('dap'), require('dapui')
				dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
				dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
				dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
			end}


		-- Treesitter
		use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
			-- branch = '0.5-compat', -- recommended for stable. But no latest updates in here
			config=function() require("treesitter")  end} -- lua + wont close () next to char finally good and simple +++
		use 'nvim-treesitter/nvim-treesitter-refactor'
		use {'romgrk/nvim-treesitter-context', disable=false, -- cool but gives orror on compe-popup - https://github.com/romgrk/nvim-treesitter-context/issues/49
			config=function() require('nv-treesittercontext')   end} -- fixes plug  }
		-- vim.cmd([[:highlight TreesitterContext guibg=#a4cf69]])
		-- use 'nvim-treesitter/nvim-treesitter-textobjects' -- cool but takes lots of keys for func, class, if, etc
		use {'mfussenegger/nvim-ts-hint-textobject',
			config=function()
				vim.api.nvim_set_keymap('o', 'u', ":<C-U>lua require('tsht').nodes()<CR>", {noremap = false, silent = true})
				vim.api.nvim_set_keymap('v', 'u', ":lua require('tsht').nodes()<CR>", {noremap = true, silent = true})
			end
		}
		use 'p00f/nvim-ts-rainbow'


		-- lsp
		use 'onsails/lspkind-nvim'  -- icons for completion popup
		use { 'rmagatti/goto-preview',  -- eg show preview directly in editable popup
			config = function() require('goto-preview').setup({default_mappings=true}) end
		}
		use { 'ms-jpq/coq_nvim', branch = 'coq', disable = true,
			setup = function() require('nv-coq') end,
		} -- main one
		use { "hrsh7th/nvim-cmp", disable=false,
			requires = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",  'quangnguyen30192/cmp-nvim-ultisnips', 'hrsh7th/cmp-calc'}, --"hrsh7th/cmp-vsnip",
			config = function() require'nv-cmp' end, }
		use {'tzachar/cmp-tabnine', requires = 'hrsh7th/nvim-cmp', run='./install.sh', disable=false,
			config = function() require('cmp_tabnine.config'):setup({
				max_lines = 100; max_num_results = 3; sort = true; })
			end}
		use {"neovim/nvim-lspconfig",
			config=function() require("lsp")  end} -- lua + wont close () next to char finally good and simple +++
		use {'SirVer/ultisnips', disable=false, --  requires='honza/vim-snippets'
			config=function()  vim.g.UltiSnipsRemoveSelectModeMappings = 0  end,}
		use {"folke/lsp-trouble.nvim",  -- shows nice icons in lsp warnings...
			requires = "kyazdani42/nvim-web-devicons",
			config = function() require("nv-lsptrouble") end,}
		use {'stevearc/aerial.nvim', disable=false, -- basically better outliner with objects type filter
			config = function() require("nv-aerial") end,}
		use {'ray-x/lsp_signature.nvim'}
		use { "ThePrimeagen/refactoring.nvim",
			requires = { {"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"} },
			config = function() require("nv-refactoring") end}


		-- Telescope
		use {'nvim-telescope/telescope.nvim',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
			config=function() require("telescope-nvim") end} -- lua + wont lose () next to char finally good and simple +++
		use 'nvim-telescope/telescope-media-files.nvim'


		-- Explorer
		use {'lambdalisue/fern.vim',
			config=vim.cmd('source ~/.config/nvim/nv_fern.vim')} -- support toggle, open cwd, drawer and splitv, fast, etc
		use {'lambdalisue/fern-git-status.vim',
			requires ='fern.vim'}
		use {'lambdalisue/fern-renderer-nerdfont.vim',
			requires ={'fern.vim', 'lambdalisue/nerdfont.vim'}}


		-- Git
		use 'tpope/vim-fugitive'    -- add :Gitxx commands
		use 'kdheepak/lazygit.nvim'
		use {'lewis6991/gitsigns.nvim',
			requires = {'nvim-lua/plenary.nvim', 'lewis6991/foldsigns.nvim'},
			config=function() require("nv-gitsigns")  end} -- lua + wont close () next to char finally good and simple +++
		use {'sindrets/diffview.nvim',
			config = function() require'diffview'.setup{} end}

		-- general
		use { "folke/which-key.nvim",
			config = function() require("nv-which-key") end }
		use { "folke/todo-comments.nvim",
			config = function() require('nv-todo') end
		}
		use {"gelguy/wilder.nvim", -- auto complete for command mode
			config = function() require('nv-wilder') end}

		--find and replace ?
		use 'kevinhwang91/nvim-bqf' --better quickfix  (with preview and complicated mapping)
		use 'brooth/far.vim' --use: Far(r) from to **/*.py   > then :Fardo
		use 'dyng/ctrlsf.vim' --Run :CtrlSF [pattern]
		use 'mhinz/vim-grepper' -- Grepper
		use 'eugen0329/vim-esearch' -- Grepper
		-- use 'pelodelfuego/vim-swoop' -- like helm-swoop from emacs. Works Only on open Buffers...it seeems
		use {'windwp/nvim-spectre',
			requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }


		--undo redo
		use { "AckslD/nvim-neoclip.lua", after='telescope.nvim',
			config = function() require('nv-neoclip')  end, }
		use 'mbbill/undotree'   -- undo history  :UndotreeToggle to toggle the undo-tree panel.
		use 'mg979/vim-localhistory' -- local history LHLoad, LHWrite


		--aligning
		use {'junegunn/vim-easy-align',  -- def:  ga  - then thing, and around what symbol :  eg  ga
			config=function() require("nv-easyalign") end} -- lua + wont close () next to char finally good and simple +++
		use 'godlygeek/tabular'
		-- use 'tommcdo/vim-lion' -- eg: glip,


		--code/format
		use 'wellle/targets.vim' -- eg ci,  ci_ etc
		use 'andymass/vim-matchup' -- increase power of %
		use {"sbdchd/neoformat", disable=true,} --verly slow with lsp or treesitter

		use {'Chiel92/vim-autoformat',
			config=function() require('nv-autoformat') end }
		use {'windwp/nvim-autopairs',  -- lua + wont close () next to char finally good and simple +++
			config=function() require('nv-autopairs') end }


		--	config=function() require('nvim_comment').setup({comment_empty = false})  end} -- in lua     o
		use 'b3nj5m1n/kommentary'
		use 'JoseConseco/vim-case-change'  -- rotate strign case - modded by me
		use {'mg979/vim-visual-multi', --multi cursor support like vscode...
			config = function() vim.g.VM_mouse_mappings=1 end,}


		-- navigation
		use {"phaazon/hop.nvim",
			config = function()
				vim.api.nvim_set_keymap('o', 'h',  ":HopChar1<cr>", {noremap = true})
				vim.api.nvim_set_keymap('n', 'gl',  ":HopLineStart<cr>", {noremap = true})
				vim.api.nvim_set_keymap('n', 'gw',  ":HopWord<cr>", {noremap = true})
			end}
		use {'karb94/neoscroll.nvim',  -- smooth scroll
			config=function() require('neoscroll').setup({hide_cursor=false}) end} -- lua + wont close () next to char finally good and simple +++
		use {'nacro90/numb.nvim',
			config=function() require('numb').setup() end } -- preview line whe using goto :xyz
		use {'axlebedev/footprints',
			config = function()
				-- vim.g.footprintsColor = '#512c4f'
				vim.g.footprintsColor = '#00c0f0'
				vim.g.footprintsOnCurrentLine = 1
				vim.g.footprintsEasingFunction = 'linear'
				vim.g.footprintsHistoryDepth = 17
			end}

		use 'vim-scripts/RelOps' -- only show relative number wien in operator pending mode

		-- ternimal in popup
		use {"akinsho/nvim-toggleterm.lua",
			config = function() require("toggleterm").setup{} end}
		use { "SmiteshP/nvim-gps", -- bread_crumbs
			requires = "nvim-treesitter/nvim-treesitter",
			config =function() require("nvim-gps").setup({
				icons = {["class-name"] = "⛬ "},
				separator = ' ▶ ',
			}) end,
		}

		--repls
		use "rafcamlet/nvim-luapad" -- :Luapad - open interactive scratch bufer with realtime eval
		use 'metakirby5/codi.vim' -- repls for all other langs ...

		-- project management
		use {"mhinz/vim-startify",
			config=function() require('nv-startify') end} -- lua + wont close () next to char finally good and simple +++
		--[[ use { "ahmedkhalf/project.nvim", -- does not store opened files in project
		config = function() require("project_nvim").setup{} end } ]]
	end
)
--vim.cmd('packloadall!') -- fixes plugs not seeing config, and load order mess. Or else we need to: so $MYVIMRC
