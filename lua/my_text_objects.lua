local ts_utils = require "nvim-treesitter.ts_utils"
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- create new text object for BIG_WORD '''
local function get_big_word(word_type)
  -- local excluded_chars = [[(\s|\(|\)|"|'|[|]|^|$)]]
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
  local search_expr = [==[\v[0-9A-Za-z\.\-\\/*_]*]==] -- \v magic
	local mode = vim.api.nvim_get_mode()['mode']  -- "no" -> operator pening, 'n' -> normal, 'v' -> visual
	-- vim.pretty_print(vim.api.nvim_get_mode())
  if word_type == "a" or mode == 'v' or mode == 'n' then -- visual, normal, and around mode
    search_expr = [==[\v\s*[0-9A-Za-z\.\-*_\s]*\s*]==] -- add \s* - any whitespaces before and after and inside []
  end
	local o_switch = false

	-- search backward
  if word_type == "i" or word_type == "a" then -- inside or around WORD
		if mode == 'v' then -- deal with wrong select range if already in visual mode
			vim.cmd "normal! o" -- switch selection side
			o_switch = true
		end
    vim.api.nvim_call_function("search", { search_expr, "cb", cur_line}) --  c-include cursor char when search, b- backward
  end

	-- deal with selection
	if mode == 'no' then -- operator pending mode
		vim.cmd "normal! v" -- (v)isual
	end
	if o_switch then
		vim.cmd "normal! o" -- switch back selection side
	end

	-- search forward
  vim.api.nvim_call_function("search", { search_expr, "e" }) -- e - move cursor to last matched char
end

local function repeatable_command(key, command_name, lua_fn, fn_args)
  vim.api.nvim_create_user_command(command_name, function()
    lua_fn(fn_args)
  end, {})
  vim.keymap.set('o', key, "<cmd>" .. command_name .. t "<CR>") -- operator pending mode
  vim.keymap.set('x', key, "<cmd>" .. command_name .. t "<CR>")  -- for vis mode <c-u> - clears '<'>
end

-- repeatable_command("o", "iW", "BigInnerWord", get_big_word, "i")
-- repeatable_command("o", "aW", "BigAroundWord", get_big_word, "a")
-- repeatable_command("o", "W", "BigWord", get_big_word, nil)
repeatable_command("iW", "BigInnerWord", get_big_word, "i")
repeatable_command("aW", "BigAroundWord", get_big_word, "a")
repeatable_command("W", "BigWord", get_big_word, nil)
vim.keymap.set('n', 'W', "<cmd>BigWord"..t "<CR>")  -- for vis mode <c-u> - clears '<'>




-- text object for function arguments '''
local function get_argument(word_type)
  -- local bufnr = vim.api.nvim_get_current_buf()
  local winid = vim.api.nvim_get_current_win()
  local is_bracket = { ["("] = true, [")"] = true, ["["] = true, ["]"] = true, ["{"] = true, ["}"] = true }
  local is_coma = { [","] = true }
  local line_text = vim.api.nvim_get_current_line()
  local cur_line = vim.api.nvim_win_get_cursor(0)[1]
	local cursor_node = ts_utils.get_node_at_cursor(winid)
	local mode = vim.api.nvim_get_mode()['mode']  -- "no" -> operator pening, 'n' -> normal, 'v' -> visual
	local o_switch = false

	-- we need to make sure we select outside cursor node, to avoid selecting node inner brackets
	local cn_row, cn_start = cursor_node:start() -- the row, column and total byte count
	local cn_end = select(2, cursor_node:end_())

	-- find outer cursor node - and grow cn_end
	local parent = cursor_node:parent()
	while select(2, parent:start()) == cn_start and select(1, parent:start()) == cn_row do
		cursor_node = parent
		cn_end = select(2, cursor_node:end_())
		parent = cursor_node:parent()
	end


	-- print(cn_start, cn_end)
  -- search  left
  local l_hit_char


	if mode == 'v' then -- deal with wrong select range if already in visual mode
		vim.cmd "normal! o" -- switch selection side
		o_switch = true
	end
  repeat
    vim.api.nvim_call_function("search", { [==[\v[\[({\,].{-}]==], "b", cur_line }) --  c-include cursor char when search, b- backward
    local l_hit_col = vim.api.nvim_win_get_cursor(0)[2]
    l_hit_char = line_text:sub(l_hit_col+1, l_hit_col+1) -- get char after cursor
		-- print(l_hit_char)
		-- print("left: ",l_hit_col)
  until l_hit_col <= cn_start -- until cursor is on the left of the node

	if not (is_bracket[l_hit_char] or is_coma[l_hit_char]) then
		return -- not in  list it seems
	end

  if is_bracket[l_hit_char] then -- skip brackets and move right
    vim.cmd "normal! l"
  end
  if word_type == "i" and is_coma[l_hit_char] then
    vim.cmd "normal! l" -- skip and move right
  end


	if mode == 'no' then -- operator pending mode
		vim.cmd "normal! v" -- (v)isual
	end
	if o_switch then
		vim.cmd "normal! o" -- switch back selection side
	end

  -- search right
  local r_hit_char
  repeat
    vim.api.nvim_call_function("search", { [==[\v.{-}[\])}\,]]==], "e", cur_line }) -- e - move cursor to last matched char
    local r_hit_col = vim.api.nvim_win_get_cursor(0)[2]
    r_hit_char = line_text:sub(r_hit_col+1, r_hit_col+1) -- get char after cursor
		-- print(r_hit_char)
		-- print("right: ", r_hit_col)
	until r_hit_col >= cn_end -- until we go after the cursor node

  if is_bracket[r_hit_char] then
    vim.cmd "normal! h" -- skip and move left
	else -- we hit coma
		if word_type ~= 'i' and is_bracket[l_hit_char] then -- remo white spaces, only if 'a' mode and left is bracket
			vim.api.nvim_call_function("search", { [==[\v\s.{-}]==], "ce", cur_line }) --  c-include cursor char when search, e- backward
		elseif word_type ~= "a" or is_coma[l_hit_char] then -- skip right comma
			vim.cmd "normal! h" -- skip and move left
		end
	end
end

repeatable_command("A", "Argument", get_argument, nil)
repeatable_command("aA", "AroundArgument", get_argument, 'a')
repeatable_command("iA", "InnerArgument", get_argument, "i")
-- vim.keymap.set("o", "A", function() get_argument(nil) end, {noremap = true, silent = true, desc = "Argument" }) -- <c-u> - clears '<, '> from input
-- vim.keymap.set("o", "iA", function() get_argument('i') end, {noremap = true, silent = true, desc = "Argument" }) -- <c-u> - clears '<, '> from input
