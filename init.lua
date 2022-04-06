local P = function(x)
  print(vim.inspect(x))
end
require "plugins"
require "hl_adjust"
-- vim.cmd('packloadall!') -- fixes plugs not seeing config, and load order mess. Or else we need to: so $MYVIMRC  but fucks up packer.sync...
require "settings"
require "keymappings"

local init_group = vim.api.nvim_create_augroup("MyInitAuGroup", { clear = true })

-- why it wont load indentline even odd correctly?
local function theme_change_timeday(start_hour, end_hour)
  local time = tonumber(vim.fn.strftime "%H")
  if time < start_hour or time > end_hour then
    vim.cmd [[colorscheme nightfox]]
  else
    vim.cmd [[colorscheme dayfox]]
  end
  vim.cmd [[doautoall ColorScheme]]
end

vim.api.nvim_create_autocmd("VimEnter", { --FocusGained
  pattern = "*",
  callback = function()
    theme_change_timeday(9, 15)
  end,
  group = init_group,
  -- nested = true, -- dow notwork in this case
})

--remove white spaces on save and restore cursor pos - using mark '.'
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[let save_pos = getpos(".") | %s/\s\+$//e | call setpos(".", save_pos)]],
  group = init_group,
})

-- NOTE: fix nvim not maximized in allacritty
vim.cmd [[
	autocmd VimEnter * :sleep 80m
	autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
]]

vim.api.nvim_create_autocmd("InsertLeave,WinLeave", {
  pattern = "*",
  command = [[:normal zv]],
  group = init_group,
}) -- zx - reclaculate folds, zv - unfold cursor line

-- vim.cmd [[
-- augroup folds
-- 	autocmd InsertLeave,WinLeave,TextYankPost * :normal zv
-- augroup END
-- ]] -- zx - reclaculate folds, zv - unfold cursor line

--[==[vim.cmd([[
augroup folds
	" Don't screw up folds when inserting text that might affect them, until
	" leaving insert mode. Foldmethod is local to the window. Protect against
	" screwing up folding when switching between windows.
	autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
	autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
augroup END
]]) ]==]

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Todo", timeout = 100 }
  end,
  group = init_group,
})

-- fix cmd line supressed messages on echo (cmp fault?)
-- see issue: https://github.com/gelguy/wilder.nvim/issues/41#issuecomment-860025867
vim.cmd [[
	function! SetShortmessF(on) abort
	  if a:on
	    set shortmess+=F
	  else
	    set shortmess-=F
	  endif
	  return ''
	endfunction

	nnoremap <expr> : SetShortmessF(1) . ':'

	augroup WilderShortmessFix
	  autocmd!
	  autocmd CmdlineLeave * call SetShortmessF(0)
	augroup END
]]
