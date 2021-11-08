-- load plugins

require("hl_adjust")
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
-- color active and unactive windows
-- vim.cmd([[ set winhighlight=Normal:Normal,NormalNC:CursorLine ]]) -- for tokyo night

-- prevent expanding comment strings on <Ret>
-- vim.cmd('autocmd FileType * set formatoptions-=r')


-- absolute <-> relative auto switch
--[[=== vim.cmd([[
autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
]) ===]]

--[==[ vim.cmd([[
	augroup telefix
	 autocmd!
	 autocmd FileType TelescopePrompt autocmd User TelescopeFindPre :ScrollViewDisable
	 autocmd FileType TelescopePrompt autocmd BufWinLeave * :ScrollViewEnable
	augroup END
]]) ]==]

-- HACK: fix nvim not maximized in allacritty
vim.cmd([[
	autocmd VimEnter * :sleep 80m
	autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
]])
-- vim.cmd [[ au BufEnter *.py,*.lua :norm zX<CR> ]] -- recalc folds for buff. but its done too often this way
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
-- disable autofoldd when edit mode - prevents edited code folding..
-- from https://vim.fandom.com/wiki/Keep_folds_closed_while_inserting_text

vim.cmd([[
augroup folds
	autocmd InsertLeave,WinLeave * :normal zv
augroup END
]])


--[==[vim.cmd([[
augroup folds
	" Don't screw up folds when inserting text that might affect them, until
	" leaving insert mode. Foldmethod is local to the window. Protect against
	" screwing up folding when switching between windows.
	autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
	autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
augroup END
]]) ]==]

