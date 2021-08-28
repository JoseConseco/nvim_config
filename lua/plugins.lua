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
	use "wbthomason/packer.nvim" -- Packer can manage itself as an optional plugin

	-- themes
	-- use 'joshdick/onedark.vim'
	use 'ful1e5/onedark.nvim'
	use 'projekt0n/github-nvim-theme'
	use {'EdenEast/nightfox.nvim',
		config=function()
				require('nightfox').setup({colors = { red="#dc6959"}})
				require('nightfox').load()
				vim.cmd([[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]])
				vim.cmd([[
				hi ActiveWindow guibg=#182534
				hi InactiveWindow guibg=#242a39
				set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow]])
			end,
		-- setup = function()  end,
	}


	use {'folke/tokyonight.nvim',
		setup=function() require('themes.tokyonight'); end,
		-- config=function() vim.cmd('colorscheme tokyonight'); vim.cmd([[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]])end
		} -- lua + wont close () next to char finally good and simple +++
	-- use {'marko-cerovac/material.nvim',
	-- 	setup=function()  vim.g.material_style = "darker"; vim.g.material_variable_color="#7f62c3"  end} -- lua + wont close () next to char finally good and simple +++
	use 'mhartington/oceanic-next'
	use {'sainnhe/edge',
		setup=function()  require('themes.edge')  end} -- lua + wont close () next to char finally good and simple +++
	use {'Luxed/ayu-vim',-- dark and lack orange                                             "
		setup=function() require('themes.ayu-vim') end} -- lua + wont close () next to char finally good and simple +++


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
		config = function() require'bufferline'.setup(); require('nv-bufferline') end
	} --uses buffers
	-- use 'psliwka/vim-smoothie' --smooth PGUP/DOWN
	use {'karb94/neoscroll.nvim',
		config=function() require('neoscroll').setup({hide_cursor=false}) end} -- lua + wont close () next to char finally good and simple +++

	use {'wfxr/minimap.vim', disable=true,-- minimap fast  but annoying - messes up windows
		config=function() require("nv-minimap") end} -- lua + wont close () next to char finally good and simple +++

	use {'nacro90/numb.nvim',
		config=function() require('numb').setup() end } -- preview line whe using goto :xyz
	use {'lukas-reineke/indent-blankline.nvim', after='tokyonight.nvim', disable=false,--  displaying thin vertical lines at each indentation level
		setup=function() require('nv-indentline') end,
		config=function() vim.cmd([[highlight! link IndentBlanklineContextChar Comment]])  end} -- preview line whe using goto :xyz
	-- use {'Xuyuanp/scrollbar.nvim', -- side scrollbar  -fucks up session load often :/
	--	config=function() require("nv-scrollbar")  end } -- preview line whe using goto :xyz
	use {'dstein64/nvim-scrollview', disable=false,
		config=function()  vim.api.nvim_exec('highlight link ScrollView Normal', false); vim.g.scrollview_character = '▎'  end}
	use {'machakann/vim-highlightedyank',
		config=function() vim.g.highlightedyank_highlight_duration = 100 end}

	--[[ use 'camspiers/lens.vim' --auto win size
	use 'camspiers/animate.vim'  --auto win size ]]


	-- Debugging
	use {'mfussenegger/nvim-dap', --too simple
		config=function() require('dap'); require('nv-dap') end } -- preview line whe using goto :xyz
	use {'mfussenegger/nvim-dap-python',
		config=function() require('dap-python').setup('/usr/bin/python') end}
	use {'theHamsta/nvim-dap-virtual-text', requires='mfussenegger/nvim-dap',
		config=function() vim.cmd([[:highlight NvimDapVirtualText guifg=#7296a9]]) end}
	use { 'rcarriga/nvim-dap-ui', requires = {'mfussenegger/nvim-dap'},
		config = function() require("dapui").setup() end}
	-- use {'puremourning/vimspector',
	--	config=function()  require("nv-vimspector") end} -- lua + wont close () next to char finally good and simple +++


	-- Treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
		-- branch = '0.5-compat', -- recommended for stable. But no latest updates in here
		config=function() require("treesitter")  end} -- lua + wont close () next to char finally good and simple +++
	use 'nvim-treesitter/nvim-treesitter-refactor'
	use {'romgrk/nvim-treesitter-context', disable=false,-- cool but gives orror on compe-popup - https://github.com/romgrk/nvim-treesitter-context/issues/49
		config=function() require('nv-treesittercontext')   end} -- fixes plug  }
-- vim.cmd([[:highlight TreesitterContext guibg=#a4cf69]])
	use 'nvim-treesitter/nvim-treesitter-textobjects'
	-- use 'nvim-treesitter/playground'
	use {'p00f/nvim-ts-rainbow', disable=false, } -- slow?


	-- lsp
	--[[ use {"hrsh7th/nvim-compe", --completion
		config=function() require("nvim-compe") end} -- lua + wont close () next to char finally good and simple +++ ]]
	use { "hrsh7th/nvim-cmp",
		requires = { "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-vsnip"},
		config = function() require'nv-cmp' end,
	}
	use {'tzachar/cmp-tabnine', requires = 'hrsh7th/nvim-cmp',
		run='./install.sh',
		config = function() require('cmp_tabnine.config'):setup({
		        max_lines = 100;
		        max_num_results = 3;
		        sort = true;
			})
		end}
	use {"neovim/nvim-lspconfig",
		config=function() require("lsp")  end} -- lua + wont close () next to char finally good and simple +++
	use {'hrsh7th/vim-vsnip',-- auto completion
		config=function() require("nv-vsnip")  end} -- lua + wont close () next to char finally good and simple +++
	--[[ use {'hrsh7th/vim-vsnip-integ',-- auto completion
		requires='hrsh7th/vim-vsnip'} -- lua + wont close () next to char finally good and simple +++ ]]
	use {'kosayoda/nvim-lightbulb', -- replaced by lspsaga
		disable=true, config=function() require("nv-lightbulb")  end} -- lua + wont close () next to char finally good and simple +++
	use 'onsails/lspkind-nvim'  -- icons for completion popup
	-- use {'codota/tabnine-vim'} -- wont work with compe
	--[[ use {'tzachar/compe-tabnine', run='./install.sh',
		requires = 'hrsh7th/nvim-compe'} ]]
	use { "folke/lsp-trouble.nvim", -- shows nice icons in lsp warnings...
		requires = "kyazdani42/nvim-web-devicons",
		config = function() require("nv-lsptrouble") end,}
	use {'stevearc/aerial.nvim', disable=false, -- basically better outliner with objects type filter
		config = function() require("nv-aerial") end,}
	use {'glepnir/lspsaga.nvim', --cool popup goto def hoover etc - but still wipp
		disable = true, config = function() require("nv-lspsaga") end,}
	use {'ray-x/lsp_signature.nvim'}
	use { "ThePrimeagen/refactoring.nvim",
		requires = { {"nvim-lua/plenary.nvim"}, {"nvim-treesitter/nvim-treesitter"} },
		config = function() require("nv-refactoring") end}

	-- Telescope
	use {'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
		config=function() require("telescope-nvim") end} -- lua + wont lose () next to char finally good and simple +++
	use 'nvim-telescope/telescope-media-files.nvim'
	-- use 'junegunn/fzf.vim'


	-- Explorer
	use {'lambdalisue/fern.vim',
		config=vim.cmd('source ~/.config/nvim/nv_fern.vim')} -- support toggle, open cwd, drawer and splitv, fast, etc
	use {'lambdalisue/fern-git-status.vim',
		requires ='fern.vim'}
	use {'lambdalisue/fern-renderer-nerdfont.vim',
		requires ={'fern.vim', 'lambdalisue/nerdfont.vim'}}

	-- git
	use 'tpope/vim-fugitive'    -- add :Gitxx commands
	use {'lewis6991/gitsigns.nvim',
		requires = 'nvim-lua/plenary.nvim',
		branch = 'foldsigns',
		config=function() require("nv-gitsigns")  end} -- lua + wont close () next to char finally good and simple +++
  use {'sindrets/diffview.nvim',
			config = function() require'diffview'.setup{} end}

	-- general
	-- use {'liuchengxu/vim-which-key',
	--	config=vim.cmd('source ~/.config/nvim/which_key.vim') }
	-- use { 'AckslD/nvim-whichkey-setup.lua',
	--	requires = {'liuchengxu/vim-which-key'} }
	use { "folke/which-key.nvim",
		config = function() require("nv-which-key") end }
	-- use {'ludovicchabant/vim-gutentags', -- lsp better..
	--      config=function() require("nv-gutentags")  end}
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
	-- use 'maxbrunsfeld/vim-yankstack' --works in normal and visual mode..<M-p> and <M-S-p> but takes  mappings for keys
	use { "AckslD/nvim-neoclip.lua", after='telescope.nvim',
    config = function() require('nv-neoclip')  end, }
	--[[ use {'svermeulen/vim-yoink', -- does not take mappings since it reads events
		config=function() require('nv-yoink') end} ]]

	use 'mbbill/undotree'   -- undo history  :UndotreeToggle to toggle the undo-tree panel.
	use 'mg979/vim-localhistory' -- local history LHLoad, LHWrite
	--     use {'chrisbra/changesPlugin', -- show local changes - EC, TC
	--			config = function() vim.cmd('source ~/.config/nvim/nv-changes.vim') end}


	--aligning
	use {'junegunn/vim-easy-align',  -- def:  ga  - then thing, and around what symbol :  eg  ga
		config=function() require("nv-easyalign") end} -- lua + wont close () next to char finally good and simple +++
	use 'godlygeek/tabular'
	use 'tommcdo/vim-lion' -- eg: glip,


	--code/format
	use 'wellle/targets.vim' -- eg ci,  ci_ etc
	use 'andymass/vim-matchup' -- increase power of %
	use {"sbdchd/neoformat", disable=true,} --verly slow with lsp or treesitter

	use {'Chiel92/vim-autoformat',
		config=function() require('nv-autoformat') end }
	use {'windwp/nvim-autopairs',  -- lua + wont close () next to char finally good and simple +++
		config=function() require('nv-autopairs') end }

	-- 	config=function() require('nvim_comment').setup({comment_empty = false})  end} -- in lua     o
	use 'b3nj5m1n/kommentary'
	use 'icatalina/vim-case-change'  -- rotate strign case - modded by me
	use 'mg979/vim-visual-multi'  --multi cursor support like vscode...


	-- navigation
	use {"phaazon/hop.nvim",
		config = function() vim.api.nvim_set_keymap('o', 'l',  ":HopChar1<cr>", {noremap = true}) end}
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
end
)
--vim.cmd('packloadall!') -- fixes plugs not seeing config, and load order mess. Or else we need to: so $MYVIMRC
