_G.P = function(x)
  print(vim.inspect(x))
end
require "plugins"
require "hl_manager"
require "settings"
require "keymappings"

local init_group = vim.api.nvim_create_augroup("MyInitAuGroup", { clear = true })

local function t(str)
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



vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Todo", timeout = 100 }
  end,
  group = init_group,
})


-- create new text object for BIG_WORD '''
local function get_big_word(mode)
	-- local excluded_chars = [[(\s|\(|\)|"|'|[|]|^|$)]]
	local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	local search_expr = [==[\v[0-9A-Za-z\.\-*_]*]==]  -- \v magic
	if mode == 'a' then
		search_expr = [==[\v[0-9A-Za-z\.\-*_ ]*]==]  -- add \s
	end
	if mode == 'i' or mode == 'a' then
		vim.api.nvim_call_function("search", {search_expr, 'cb', cur_line}) --  c-include cursor char when search, b- backward
	end
	vim.cmd("normal! v")  -- (v)isual
	vim.api.nvim_call_function("search", {search_expr, 'ce', cur_line})    -- e - move cursor to last matched char
end

local function repeatable_command(mode, key, command_name, lua_fn, fn_args)
	-- requires tpope/vim-repeat - allows . repeat
	vim.api.nvim_create_user_command( command_name, function() lua_fn(fn_args) end, {})
	vim.fn['repeat#set'](':'..command_name..t'<CR>')
	vim.keymap.set(mode, key, ':'..command_name..t'<CR>')
end

repeatable_command('o', 'iW', 'BigInnerWord', get_big_word, 'i')
repeatable_command('o', 'aW', 'BigAroundWord', get_big_word, 'a')
repeatable_command('o', 'W', 'BigWord',get_big_word,  nil)


-- text object for function arguments '''
local function get_argument(mode)
	local is_bracket = {['(']=true, [')']=true, ['[']=true, [']']=true, ['{']=true, ['}']=true}
	local is_coma = {[',']=true}
	local line_text = vim.api.nvim_get_current_line()
	local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	-- search  left
	vim.api.nvim_call_function("search", {[==[\v[\[({\,].{-}]==], 'b', cur_line}) --  c-include cursor char when search, b- backward
	local l_hit_col = vim.api.nvim_win_get_cursor(0)[2]
	local l_hit_char = line_text:sub(l_hit_col+1, l_hit_col+1) -- get char after cursor
	if is_bracket[l_hit_char] then
			vim.cmd("normal! l")  -- skip and move right
	end
	if is_coma[l_hit_char] and mode == 'i' then
			vim.cmd("normal! l")  -- skip and move right
	end

	vim.cmd("normal! v")  -- (v)isual

	-- search right
	vim.api.nvim_call_function("search", {[==[\v.{-}[\])}\,]]==], 'e', cur_line})    -- e - move cursor to last matched char
	local r_hit_col = vim.api.nvim_win_get_cursor(0)[2]
	local r_hit_char = line_text:sub(r_hit_col+1, r_hit_col+1) -- get char after cursor
	if is_bracket[r_hit_char] then
		vim.cmd("normal! h")  -- skip and move left
	end
	if is_coma[r_hit_char] and (is_coma[l_hit_char] or mode == 'i') then -- skip right comma
			vim.cmd("normal! h")  -- skip and move left
	end
end

-- repeatable_command('o', 'A', 'Argument', 'i')
repeatable_command('o', 'A', 'Argument', get_argument, nil)
repeatable_command('o', 'iA', 'InnerArgument', get_argument, 'i')
-- vim.keymap.set("o", "A", function() get_argument(nil) end, {noremap = true, silent = true, desc = "Argument" }) -- <c-u> - clears '<, '> from input
-- vim.keymap.set("o", "iA", function() get_argument('i') end, {noremap = true, silent = true, desc = "Argument" }) -- <c-u> - clears '<, '> from input



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
