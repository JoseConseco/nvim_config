-- load plugins
require("plugins")
require('settings')
require('keymappings')

-- set themes props before loading actuall theme
require('themes.edge')
require('themes.ayu-vim')
vim.cmd('colorscheme edge') -- onedark, OceanicNext, edge


require("web-devicons")
require("nv-galaxyline")   -- status line
require('nv-startify')
require("telescope-nvim")
require'telescope'.load_extension('sessions')

-- lsp
require("lsp")
require("nv-vsnip")
require("nvim-compe")

require("treesitter")
require("nv-gitsigns")
require("nv-minimap") -- F3 vscode like minimap
require("nv-indentline") -- vertical line on indent
require("nv-vimspector") --debug
require("nv-easyalign")  -- gaip=    align paragraph around = sign
require("nv-scrollbar")
require("nv-yankstack")

require('colorizer').setup()
require('nvim_comment').setup({comment_empty = false})
require('numb').setup() --thing that previews go to line..
require('bufferline').setup()
require('nv-bufferline')
require('nv-autopairs')
-- ~/.local/lib/python3.9/site-package - debugpy is here (pip show debugpy)
-- require('dap-python').setup('/usr/bin/python')

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- fern file explorer config
vim.cmd('source ~/.config/nvim/nv_fern.vim')

-- Which Key (Hope to replace with Lua plugin someday)
vim.cmd('source ~/.config/nvim/which_key.vim')
-- require('nv-which-key')

 --remove white spaces on save and restore cursor pos - using mark '.'
vim.cmd('autocmd BufWritePre * let save_pos = getpos(".") | %s/\\s\\+$//e | call setpos(".", save_pos)')

-- prevent expanding comment strings on <Ret>
vim.cmd('autocmd FileType * set formatoptions-=r')


-- absolute <-> relative auto switch
vim.cmd([[
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
]])

--close NTree on quit..does not work on session it seems
-- vim.cmd('autocmd VimLeave * NERDTreeClose')

-- vim.cmd(':luafile $MYVIMRC')

