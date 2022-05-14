local ts_utils = require "nvim-treesitter.ts_utils"
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- create new text object for BIG_WORD '''
local function get_big_word(mode)
  -- local excluded_chars = [[(\s|\(|\)|"|'|[|]|^|$)]]
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local search_expr = [==[\v[0-9A-Za-z\.\-*_]*]==] -- \v magic
  if mode == "a" then
    search_expr = [==[\v[0-9A-Za-z\.\-*_ ]*]==] -- add \s
  end
  if mode == "i" or mode == "a" then
    vim.api.nvim_call_function("search", { search_expr, "cb", cur_line }) --  c-include cursor char when search, b- backward
  end
  vim.cmd "normal! v" -- (v)isual
  vim.api.nvim_call_function("search", { search_expr, "ce", cur_line }) -- e - move cursor to last matched char
end

local function repeatable_command(mode, key, command_name, lua_fn, fn_args)
  vim.api.nvim_create_user_command(command_name, function()
    lua_fn(fn_args)
  end, {})
  vim.keymap.set(mode, key, ":" .. command_name .. t "<CR>")
end

repeatable_command("o", "iW", "BigInnerWord", get_big_word, "i")
repeatable_command("o", "aW", "BigAroundWord", get_big_word, "a")
repeatable_command("o", "W", "BigWord", get_big_word, nil)

-- text object for function arguments '''
local function get_argument(mode)
  -- local bufnr = vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()
  local is_bracket = { ["("] = true, [")"] = true, ["["] = true, ["]"] = true, ["{"] = true, ["}"] = true }
  local is_coma = { [","] = true }
  local line_text = vim.api.nvim_get_current_line()
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]

  -- search  left
  local l_hit_char
  repeat
    vim.api.nvim_call_function("search", { [==[\v[\[({\,].{-}]==], "b", cur_line }) --  c-include cursor char when search, b- backward
    local cursor_node = ts_utils.get_node_at_cursor(winid)
    local l_hit_col = vim.api.nvim_win_get_cursor(0)[2]
    l_hit_char = line_text:sub(l_hit_col + 1, l_hit_col + 1) -- get char after cursor
  until cursor_node:type() ~= "string" -- while we are in string continue searching

	if not (is_bracket[l_hit_char] or is_coma[l_hit_char]) then
		-- not in  list it seems
		return
	end

  if is_bracket[l_hit_char] then -- skip brackets and move right
    vim.cmd "normal! l"
  end
  if mode == "i" and is_coma[l_hit_char] then
    vim.cmd "normal! l" -- skip and move right
  end

	-- (v)isual
  vim.cmd "normal! v"

  -- search right
  local r_hit_char
  repeat
    vim.api.nvim_call_function("search", { [==[\v.{-}[\])}\,]]==], "e", cur_line }) -- e - move cursor to last matched char
    local cursor_node = ts_utils.get_node_at_cursor(winid)
    local r_hit_col = vim.api.nvim_win_get_cursor(0)[2]
    r_hit_char = line_text:sub(r_hit_col + 1, r_hit_col + 1) -- get char after cursor
  until cursor_node:type() ~= "string" -- while we are in string continue searching

  if is_bracket[r_hit_char] then
    vim.cmd "normal! h" -- skip and move left
	else -- we hit coma
		if mode == 'a' and  is_bracket[l_hit_char] then -- remo white spaces, only if 'a' mode and left is bracket
			vim.api.nvim_call_function("search", { [==[\v[^\s]{-}]==], "", cur_line }) --  c-include cursor char when search, b- backward
		elseif mode == "i" or is_coma[l_hit_char] then -- skip right comma
			vim.cmd "normal! h" -- skip and move left
		end
	end
end

repeatable_command("o", "A", "Argument", get_argument, nil)
repeatable_command("o", "aA", "AroundArgument", get_argument, 'a')
repeatable_command("o", "iA", "InnerArgument", get_argument, "i")
-- vim.keymap.set("o", "A", function() get_argument(nil) end, {noremap = true, silent = true, desc = "Argument" }) -- <c-u> - clears '<, '> from input
-- vim.keymap.set("o", "iA", function() get_argument('i') end, {noremap = true, silent = true, desc = "Argument" }) -- <c-u> - clears '<, '> from input
