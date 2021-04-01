-- load plugins
require("plugins")
require('settings')
require('keymappings')

vim.cmd('let g:nvcode_termcolors=256')
--vim.cmd('colorscheme onedark')
vim.cmd('colorscheme OceanicNext')

require("web-devicons")
require("nv-galaxyline")   -- status line
require('nv-startify')
-- require("nvimTree")
require("telescope-nvim")

-- lsp
require("lsp")
require("nvim-compe")
require("nv-vsnip")

require("treesitter")
require("nv-gitsigns")
require("nv-minimap")

require('colorizer').setup()
require('nvim_comment').setup({comment_empty = false})
require('nvim-autopairs').setup()

-- fix json nod drawing " due to indentLine plug
vim.cmd('autocmd Filetype json :IndentLinesDisable')
vim.cmd('autocmd Filetype markdown :IndentLinesDisable')

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]


-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/which_key.vim')

 --remove white spaces on save and restore cursor pos - using mark '.'
vim.cmd('autocmd BufWritePre * let save_pos = getpos(".") | %s/\\s\\+$//e | call setpos(".", save_pos)')

-- prevent expanding comment strings on <Ret>
vim.cmd('autocmd FileType * set formatoptions-=r')

--close NTree on quit..does not work on session it seems
-- vim.cmd('autocmd VimLeave * NERDTreeClose')

-- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
vim.cmd('autocmd BufEnter * if bufname(\'#\') =~ \'NERD_tree_\\d\\+\' && bufname(\'%\') !~ \'NERD_tree_\\d\\+\' && winnr(\'$\') > 1 | let buf=bufnr() | buffer# | execute "normal! \\<C-W>w" | execute \'buffer\'.buf | endif')

