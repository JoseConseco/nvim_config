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
	opt_default=false, -- def -false; if true: default to using opt (as opposed to start) plugins
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
	use 'joshdick/onedark.vim'
	use {'folke/tokyonight.nvim',
		config=function()  require('themes.tokyonight')  end} -- lua + wont close () next to char finally good and simple +++
	use {'marko-cerovac/material.nvim',
		config=function()  vim.g.material_style = "darker"; vim.g.material_variable_color="#7f62c3"  end} -- lua + wont close () next to char finally good and simple +++
	use 'mhartington/oceanic-next'
	use {'sainnhe/edge',
		config=function()  require('themes.edge')  end} -- lua + wont close () next to char finally good and simple +++
	use {'Luxed/ayu-vim', -- dark and lack orange
		config=function() require('themes.ayu-vim') end} -- lua + wont close () next to char finally good and simple +++


	-- UI
	use {'norcalli/nvim-colorizer.lua',
		config=function() require('colorizer').setup() end}  --color highlighter
	use "kyazdani42/nvim-web-devicons"
	use {"ryanoasis/vim-devicons",
		config=function() require("web-devicons") end} -- lua + wont close () next to char finally good and simple +++
	use {'glepnir/galaxyline.nvim', --status line and bufferline
		requires = {'kyazdani42/nvim-web-devicons'},
		config=function() require("nv-galaxyline") end} -- lua + wont close () next to char finally good and simple +++
	use {'akinsho/nvim-bufferline.lua',
		requires = 'kyazdani42/nvim-web-devicons',
		config = function() require'bufferline'.setup(); require('nv-bufferline') end
	} --uses buffers
	use 'psliwka/vim-smoothie' --smooth PGUP/DOWN
	use {'wfxr/minimap.vim', -- minimap fast
		disable=true,
		config=function() require("nv-minimap") end} -- lua + wont close () next to char finally good and simple +++

	use {"mhinz/vim-startify",
		config=function() require('nv-startify') end} -- lua + wont close () next to char finally good and simple +++
	-- use 'junegunn/vim-peekaboo' -- show content of registers when using " or @
	-- use "tversteeg/registers.nvim"  -- show content of registers when using " - replaced by new lua which_key
	use {'nacro90/numb.nvim',
		config=function() require('numb').setup() end } -- preview line whe using goto :xyz
	use 'Yggdroot/indentLine' --  displaying thin vertical lines at each indentation level
	-- use {'Xuyuanp/scrollbar.nvim', -- side scrollbar  -fucks up session load often :/
	--	config=function() require("nv-scrollbar")  end } -- preview line whe using goto :xyz
	use {'dstein64/nvim-scrollview',
		config=function()  vim.api.nvim_exec('highlight link ScrollView Normal', false); vim.g.scrollview_character = '▎'  end}


	-- Debugging
	use {'mfussenegger/nvim-dap-python',
		config=function() require('dap-python').setup('/usr/bin/python') end}
	use {'mfussenegger/nvim-dap', requires='mfussenegger/nvim-dap-python', --too simple
		config=function() require('nv-dap') end } -- preview line whe using goto :xyz
	use {'theHamsta/nvim-dap-virtual-text', requires='mfussenegger/nvim-dap'}
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"},
		config = function() require("dapui").setup() end}
	-- use {'puremourning/vimspector',
	--	config=function()  require("nv-vimspector") end} -- lua + wont close () next to char finally good and simple +++


	-- Treesitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate',
		config=function() require("treesitter")  end} -- lua + wont close () next to char finally good and simple +++
	use 'nvim-treesitter/nvim-treesitter-refactor'
	-- use 'nvim-treesitter/playground'
	use {'p00f/nvim-ts-rainbow', disable=true, } -- slow?


	-- lsp
	use {"hrsh7th/nvim-compe", --completion
		config=function() require("nvim-compe") end} -- lua + wont close () next to char finally good and simple +++
	use {"neovim/nvim-lspconfig",
		config=function() require("lsp")  end} -- lua + wont close () next to char finally good and simple +++
	use {'hrsh7th/vim-vsnip',-- auto completion
		config=function() require("nv-vsnip")  end} -- lua + wont close () next to char finally good and simple +++
	use {'hrsh7th/vim-vsnip-integ',-- auto completion
		requires='hrsh7th/vim-vsnip'} -- lua + wont close () next to char finally good and simple +++
	use {'kosayoda/nvim-lightbulb', -- replaced by lspsaga
		disable=true,
		config=function() require("nv-lightbulb")  end} -- lua + wont close () next to char finally good and simple +++
	use 'onsails/lspkind-nvim'  -- icons for completion popup
	-- use {'codota/tabnine-vim'} -- wont work with compe
	use {'tzachar/compe-tabnine', run='./install.sh',
		requires = 'hrsh7th/nvim-compe'}
	use { "folke/lsp-trouble.nvim", -- shows nice icons in lsp warnings...
		requires = "kyazdani42/nvim-web-devicons",
		config = function() require("nv-lsptrouble") end,}
	use {'simrat39/symbols-outline.nvim', -- :SymbolsOutline
		config = function() require('symbols-outline').setup({highlight_hovered_item = false}) end}
	use {'glepnir/lspsaga.nvim', --cool popup goto def hoover etc - but still wipp
		disable = true,
		config = function() require("nv-lspsaga") end,}
	-- Telescope
	use {'nvim-telescope/telescope.nvim',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
		config=function() require("telescope-nvim") end} -- lua + wont lose () next to char finally good and simple +++
	use 'nvim-telescope/telescope-media-files.nvim'
	use 'junegunn/fzf.vim'


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

	--find and replace ?
	use 'kevinhwang91/nvim-bqf' --better quickfix  (with preview and complicated mapping)
	use 'brooth/far.vim' --use: Far(r) from to **/*.py   > then :Fardo
	use 'dyng/ctrlsf.vim' --Run :CtrlSF [pattern]
	use 'mhinz/vim-grepper' -- Grepper
	-- use 'pelodelfuego/vim-swoop' -- like helm-swoop from emacs. Works Only on open Buffers...it seeems
	use {'windwp/nvim-spectre',
		requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }


	--undo redo
	-- use 'maxbrunsfeld/vim-yankstack' --works in normal and visual mode..<M-p> and <M-S-p>
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
		-- use 'chaoren/vim-wordmotion' -- adds eg support for different snake case as individual words
		use 'tpope/vim-surround' -- eg cs'" -> changes ' to "
		-- use 'blackcauldron7/surround.nvim' --hotkye s taken, plus unstable?
		use 'wellle/targets.vim' -- eg ci,  ci_ etc
		use 'andymass/vim-matchup' -- increase power of %
		-- use {'lukas-reineke/indent-blankline.nvim', branch = 'lua', disable = true} -- add indents on blank lines
		use {"sbdchd/neoformat",  --verly slow with lsp or treesitter
		disable=true,}
		use {'Chiel92/vim-autoformat',
		config=function() require('nv-autoformat') end }
		use {'windwp/nvim-autopairs',  -- lua + wont close () next to char finally good and simple +++
		-- comit='b8272f539017ffb6de6a05247e7c333b3721279b',
			config=function() require('nv-autopairs') end }

		use {'terrortylor/nvim-comment',
		config=function() require('nvim_comment').setup({comment_empty = false})  end} -- in lua     o
		use 'icatalina/vim-case-change'  -- rotate strign case - modded by me
		use 'mg979/vim-visual-multi'  --multi cursor support like vscode...

		--spell check
		use {'kamykn/spelunker.vim',  -- zl - correct, or Zc, Zf
		config=function() require('nv-spelunker') end} -- in lua     o

		-- navigation
		use "phaazon/hop.nvim"
		-- use 'rhysd/clever-f.vim' -- f,t,F,T, repeat fff.. to search next occurance of x - wont work with macros!
		use {'justinmk/vim-sneak',
		config = function() vim.cmd('source ~/.config/nvim/nv-sneak.vim') end}
		-- ternimal in popup
		use { "numtostr/FTerm.nvim", -- flaot term
		config = function() require("FTerm").setup() end }
		--repls
		use "rafcamlet/nvim-luapad" -- :Luapad - open interactive scratch bufer with realtime eval
		use 'metakirby5/codi.vim' -- repls for all other langs ...
		use 'camspiers/lens.vim' --auto win size


end
)
--vim.cmd('packloadall!') -- fixes plugs not seeing config, and load order mess. Or else we need to: so $MYVIMRC
