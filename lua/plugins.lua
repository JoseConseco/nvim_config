-- check if packer is installed (~/local/share/nvim/site/pack)
-- local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

-- vim.cmd [[packadd packer.nvim]]
local install_path = vim.fn.stdpath('data') ..  '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.api.nvim_command('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.api.nvim_command 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua
require("packer").init({clone_timeout=100})
return require("packer").startup(
	function(use)
		use "wbthomason/packer.nvim" -- Packer can manage itself as an optional plugin

		-- themes
		use 'joshdick/onedark.vim'
		use 'mhartington/oceanic-next'
		use 'sainnhe/edge'
		use 'Luxed/ayu-vim' -- dark and lack orange


		-- UI
		use 'norcalli/nvim-colorizer.lua'  --color highlighter
		use "kyazdani42/nvim-web-devicons"
		use "ryanoasis/vim-devicons"
		use {'glepnir/galaxyline.nvim', --status line and bufferline
			requires = {'kyazdani42/nvim-web-devicons', opt = true}
		}
		-- use 'romgrk/barbar.nvim' --tabline plugin --uses tabs rather than buff tabs...
		use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'} --uses buffers
		use 'psliwka/vim-smoothie' --smooth PGUP/DOWN
		use 'wfxr/minimap.vim' -- minimap fast
		use "mhinz/vim-startify"
		-- use 'junegunn/vim-peekaboo' -- show content of registers when using " or @
		use "tversteeg/registers.nvim"  -- show content of registers when using "
		use 'nacro90/numb.nvim' -- preview line whe using goto :xyz
		use 'Yggdroot/indentLine' --  displaying thin vertical lines at each indentation level
		use 'Xuyuanp/scrollbar.nvim' -- side scrollbar


		-- Debugging
		-- use 'mfussenegger/nvim-dap'  --too simple
		-- use {'mfussenegger/nvim-dap-python', requires='mfussenegger/nvim-dap'}
		use 'puremourning/vimspector'


		-- Treesitter
		use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
		use 'nvim-treesitter/nvim-treesitter-refactor'
		-- use 'nvim-treesitter/playground'
		use 'p00f/nvim-ts-rainbow'


		-- lsp
		use "hrsh7th/nvim-compe" --completion
		use "neovim/nvim-lspconfig"
		use 'hrsh7th/vim-vsnip'-- auto completion
		use 'kosayoda/nvim-lightbulb'
		use 'onsails/lspkind-nvim'  -- icons for completion popup
		-- use {'codota/tabnine-vim'} -- wont work with compe
		use {'tzachar/compe-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-compe'}


		-- Telescope
		use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
		use 'nvim-telescope/telescope-media-files.nvim'
		use 'junegunn/fzf.vim'


		-- Explorer
		-- use 'preservim/nerdtree'
		-- use {'Xuyuanp/nerdtree-git-plugin', requires ='preservim/nerdtree'}
		use 'lambdalisue/fern.vim' -- support toggle, open cwd, drawer and splitv, fast, etc
		use {'lambdalisue/fern-git-status.vim', requires ='fern.vim'}
		-- use 'kyazdani42/nvim-tree.lua' --mech - lack customization..

		-- git
		use 'tpope/vim-fugitive'    -- add :Gitxx commands
		use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}


		-- general
		use 'liuchengxu/vim-which-key'
		use { 'AckslD/nvim-whichkey-setup.lua', requires = {'liuchengxu/vim-which-key'} }


		--find and replace ?
		use 'kevinhwang91/nvim-bqf' --better quickfix  (with preview and complicated mapping)
		use 'brooth/far.vim' --use: Far(r) from to **/*.py   > then :Fardo
		use 'dyng/ctrlsf.vim' --Run :CtrlSF [pattern]
		use 'mhinz/vim-grepper' -- Grepper
		-- use 'pelodelfuego/vim-swoop' -- like helm-swoop from emacs. Works Only on open Buffers...it seeems
		use {'windwp/nvim-spectre', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }


    --undo redo
		use 'maxbrunsfeld/vim-yankstack' --works in normal and visual mode..<M-p> and <M-S-p>
		use 'mbbill/undotree'   -- undo history  :UndotreeToggle to toggle the undo-tree panel.
		use 'mg979/vim-localhistory' -- local history LHLoad, LHWrite


		--aligning
		use 'junegunn/vim-easy-align'  -- def:  ga  - then thing, and around what symbol :  eg  ga
		use 'godlygeek/tabular'
		use 'tommcdo/vim-lion' -- eg: glip,


		--code/format
		use 'chaoren/vim-wordmotion' -- adds eg support for different snake case as individual words
		use 'tpope/vim-surround' -- eg cs'" -> changes ' to "
			-- use 'blackcauldron7/surround.nvim' --hotkye s taken, plus unstable?
		use 'wellle/targets.vim' -- eg ci,  ci_ etc
		use 'andymass/vim-matchup' -- increase power of %
		-- use {'lukas-reineke/indent-blankline.nvim', branch = 'lua', disable = true} -- add indents on blank lines
		use "sbdchd/neoformat"
		use 'windwp/nvim-autopairs' -- lua + wont close () next to char finally good and simple +++

		use 'terrortylor/nvim-comment' -- in lua     o
		use 'icatalina/vim-case-change'  -- rotate strign case - modded by me
		use 'mg979/vim-visual-multi'  --multi cursor support like vscode...

		--spell check
		-- use 'kamykn/spelunker.vim'  -- zl - correct, or Zc, Zf


		-- navigation
		use "phaazon/hop.nvim"
		use 'rhysd/clever-f.vim' -- f,t,F,T, repeat fff.. to search next occurance of x

		-- ternimal in popup
		use {
			"numtostr/FTerm.nvim",
			config = function()
				require("FTerm").setup()
			end
}
	  --repls
		use "rafcamlet/nvim-luapad" -- :Luapad - open interactive scratch bufer with realtime eval
		use 'metakirby5/codi.vim' -- repls for all other langs ...
		use 'camspiers/lens.vim' --auto win size
    end
)
