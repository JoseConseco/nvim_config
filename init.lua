-- load plugins

require('plugins')
-- vim.cmd('packloadall!') -- fixes plugs not seeing config, and load order mess. Or else we need to: so $MYVIMRC  but fucks up packer.sync...
require('settings')
require('keymappings')

-- set themes props before loading actuall theme ?
-- vim.cmd('colorscheme tokyonight')  -- onedark, OceanicNext, edge

require'telescope'.load_extension('sessions')

-- ~/.local/lib/python3.9/site-package - debugpy is here (pip show debugpy)
-- require('dap-python').setup('/usr/bin/python')

-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

 --remove white spaces on save and restore cursor pos - using mark '.'
vim.cmd('autocmd BufWritePre * let save_pos = getpos(".") | %s/\\s\\+$//e | call setpos(".", save_pos)')

-- prevent expanding comment strings on <Ret>
-- vim.cmd('autocmd FileType * set formatoptions-=r')


-- absolute <-> relative auto switch
-- vim.cmd([[
-- autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
-- autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
-- ]])
-- line numbers
-- vim.api.nvim_exec([[
-- augroup MyColors
-- 	autocmd!
-- 	autocmd ColorScheme * highlight LineNr guifg=#5081c0   | highlight CursorLineNR guifg=#FFba00
-- augroup END
-- ]], false)
-- vim.api.nvim_exec([[
-- autocmd User VimspectorUICreated autocmd CursorHold *.py  :execute "normal \<Plug>VimspectorBalloonEval"
-- ]],false)

--close NTree on quit..does not work on session it seems
-- vim.cmd('autocmd VimLeave * NERDTreeClose')

-- local my_vimrc = vim.fn.expand('$MYVIMRC')
-- vim.cmd(':luafile '..my_vimrc) --cos some colors do not load correctly..

