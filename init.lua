-- load plugins
require("plugins")
require('settings')

vim.cmd('colorscheme onedark')
vim.cmd('let g:nvcode_termcolors=256')

require("web-devicons")
require("nv-galaxyline")   -- status line
require("nvimTree")
require("telescope-nvim")

-- lsp
require("lsp")
require("nvim-compe")
require("vsnip")

require("gitsigns")
require("treesitter")
require('nv-startify')

require('colorizer').setup()
require('nvim_comment').setup({comment_empty = false})
require('nvim-autopairs').setup()

-- fix json nod drawing " due to indentLine plug
vim.cmd('autocmd Filetype json :IndentLinesDisable')
vim.cmd('autocmd Filetype markdown :IndentLinesDisable')

require('keymappings')

-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/which_key.vim')

vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e')  --remove white spaces

-- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
vim.cmd([[autocmd BufEnter \* if bufname('#') =~ 'Vim-tree_\\d\\+' && bufname('%') !~ 'Vim-tree_\\d\\+' && winnr('$') > 1 |
    \\ let buf=bufnr() | buffer# | execute "normal! \\<C-W>w" | execute 'buffer'.buf | endif]])
