local P = function(x)
  print(vim.inspect(x))
end
require "plugins"
require "hl_manager"
-- vim.cmd('packloadall!') -- fixes plugs not seeing config, and load order mess. Or else we need to: so $MYVIMRC  but fucks up packer.sync...
require "settings"
require "keymappings"

local init_group = vim.api.nvim_create_augroup("MyInitAuGroup", { clear = true })

local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

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


vim.api.nvim_create_autocmd({"BufEnter","InsertLeave","TextYankPost", "WinEnter"}, { --"TextChanged"
  pattern = "*",
  callback = function()
		-- print("open fold")
    local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
		-- print("row: "..line_data[1])
    local fold_closed = vim.fn.foldclosed(line_data[1]) -- -1 if no fold at line
		-- print("closed: "..fold_closed)
    if fold_closed < line_data[1] and fold_closed ~= -1 then --fold before cursor, and fold exist (not -1)
      vim.cmd [[normal! zv]]
    end
  end,
  group = init_group,
})


 -- go to last loc when opening a buffer
vim.api.nvim_create_autocmd( "BufReadPost", {
		command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
		group = init_group,
})

-- NOTE: fix nvim not maximized in allacritty
vim.cmd [[
	autocmd VimEnter * :sleep 80m
	autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
]]

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

-- create new text object for big Word
local function get_big_word()
	local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	-- local excluded_chars = [[(\s|\(|\)|"|'|[|]|^|$)]]
	local search_expr = [==[\v[0-9A-Za-z\.\-*_]*]==]  -- \v magic
	local after_search_line = vim.api.nvim_call_function("search", {search_expr, 'cb', cur_line})
	vim.pretty_print(cur_line, after_search_line)
	vim.cmd("normal! v")  -- (v)isual
	vim.api.nvim_call_function("search", {search_expr, 'ce', cur_line})
end
vim.keymap.set("o", "W", get_big_word, {noremap = true, silent = true, desc = "Big Word alternative" }) -- <c-u> - clears '<, '> from input


-- fix cmd line suppressed messages on echo (cmp fault?)
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

-- TabMessage messages - will put output of :messages into buffer
vim.cmd[[
 function! MessagesBuffer(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction

command! -nargs=+ -complete=command MessagesInBuffer call MessagesBuffer(<q-args>)
]]
