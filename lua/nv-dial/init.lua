local augend = require "dial.augend"
require("dial.config").augends:register_group {
	-- default augends used when no group name is specified
	default = {
		-- augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
		-- augend.hexcolor.new({case="upper"}), -- nonnegative hex number  (0x01, 0x1a1f, etc.)
		augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
		augend.constant.alias.bool,
		-- augend.paren.alias.brackets,
		-- augend.paren.alias.quote,
		--     augend.constant.new {
		--       elements = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "A", "B", "C", "D", "E", "F" },
		--       word = false,
		--       cyclic = true,
		-- case = "upper",
		--     },
		augend.user.new {
			find = require("dial.augend.common").find_pattern "%x",
			add = function(text, addend, cursor)
				local n = tonumber(text, 16)
				if n then
					n = math.fmod(n + addend, 16)
				else
					n = 0
				end
				text = string.format("%X", n) -- text = tostring(n)
				cursor = #text
				return { text = text, cursor = cursor }
			end,
		},
		-- augend.paren.new { -- breaks eg. number increase if it is in brackets...
		--   patterns = { { "(", ")" }, { "[", "]" }, { "{", "}" }, { "(", ")" }, { "'", "'" }, { '"', '"' }, { "'", "'" } },
		--   nested = false,
		--   cyclic = false,
		-- },
		augend.constant.new {
			elements = { "True", "False" },
			word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
			cyclic = true, -- "or" is incremented into "and".
		},
		augend.constant.new {
			elements = { "==", "!=" },
			word = false, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
			cyclic = true, -- "or" is incremented into "and".
		},
	},

	-- augends used when group with name `mygroup` is specified
	mygroup = {
		augend.integer.alias.decimal,
		augend.constant.alias.bool, -- boolean value (true <-> false)
		augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
	},
}
vim.api.nvim_set_keymap("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.api.nvim_set_keymap("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
vim.api.nvim_set_keymap("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })
