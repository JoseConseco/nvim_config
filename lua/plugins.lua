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

		-- Color
		use 'joshdick/onedark.vim'
		use 'mhartington/oceanic-next'
		use 'norcalli/nvim-colorizer.lua'  --color highlighter
    -- use 'sheerun/vim-polyglot' -- more coloring on top of tree-sitterg

        -- UI
        use "kyazdani42/nvim-web-devicons"
        use "ryanoasis/vim-devicons"
        use {'glepnir/galaxyline.nvim', --status line and bufferline
                -- your statusline
                -- config = function() require'my_statusline' end,
                -- some optional icons
                requires = {'kyazdani42/nvim-web-devicons', opt = true}
            }
		use 'romgrk/barbar.nvim' --tabline plugin
		use 'wfxr/minimap.vim' -- minimap fast

		-- Debugging
		-- use 'mfussenegger/nvim-dap'
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
		use 'preservim/nerdtree'
		use {'Xuyuanp/nerdtree-git-plugin', requires ='preservim/nerdtree'}
        -- use 'kyazdani42/nvim-tree.lua'

        -- git
		use 'tpope/vim-fugitive'    -- add :Gitxx commands
        use {'lewis6991/gitsigns.nvim', requires = 'nvim-lua/plenary.nvim'}

        -- general
        use 'liuchengxu/vim-which-key'
        -- use 'Yggdroot/indentLine' --  displaying thin vertical lines at each indentation level
		use {'lukas-reineke/indent-blankline.nvim', branch = 'lua'} -- add indents on blank lines
        use "sbdchd/neoformat"
        -- use "alvan/vim-closetag"
        -- use 'airblade/vim-rooter' -- change root dir :Rooter
        use 'jiangmiao/auto-pairs'

		use 'terrortylor/nvim-comment' -- in lua


        use 'psliwka/vim-smoothie'
        use "mhinz/vim-startify"
        use "phaazon/hop.nvim"
        -- use 'blackcauldron7/surround.nvim' --hotkye s taken, plus unstable?
		use 'tpope/vim-surround'
		use 'mg979/vim-localhistory' -- local history LHLoad, LHWrite
		use 'icatalina/vim-case-change'
		use 'mbbill/undotree'   -- undo history  :UndotreeToggle to toggle the undo-tree panel.
		use 'junegunn/vim-easy-align'  -- def:  ga  - then thing, and around what symbol :  eg  ga
		use 'mg979/vim-visual-multi'  --multi cursor support like vscode...
		use 'junegunn/vim-peekaboo' -- show content of registers when using " or @
    end
)
