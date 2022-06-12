_G.P = function(x)
  print(vim.inspect(x))
end
require "plugins"
require "hl_manager"
require "settings"
require "keymappings"
require "my_text_objects"

local init_group = vim.api.nvim_create_augroup("MyInitAuGroup", { clear = true })

-- why it wont load indentline even odd correctly?
local function theme_change_timeday(start_hour, end_hour)
  local time = tonumber(vim.fn.strftime "%H")
	local current_theme = vim.g.colors_name
  if time < start_hour or time > end_hour then
		if current_theme ~= "nightfox" then
			-- print("Changing theme to nightfox")
			vim.cmd [[colorscheme nightfox]]
		end
  else
		if current_theme ~= "dayfox" then
			-- print("Changing theme to dayfox")
			vim.cmd [[colorscheme dayfox]]
		end
  end
  vim.cmd [[doautoall ColorScheme]]
end

vim.api.nvim_create_autocmd({"VimEnter","FocusLost"}, { --FocusGained
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


vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Todo", timeout = 100 }
  end,
  group = init_group,
})


-- -- fix cmd line suppressed messages on echo (cmp fault?)
-- -- see issue: https://github.com/gelguy/wilder.nvim/issues/41#issuecomment-860025867
-- vim.cmd [[
-- 	function! SetShortmessF(on) abort
-- 	  if a:on
-- 	    set shortmess+=F
-- 	  else
-- 	    set shortmess-=F
-- 	  endif
-- 	  return ''
-- 	endfunction
--
-- 	nnoremap <expr> : SetShortmessF(1) . ':'
--
-- 	augroup WilderShortmessFix
-- 	  autocmd!
-- 	  autocmd CmdlineLeave * call SetShortmessF(0)
-- 	augroup END
-- ]]

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
