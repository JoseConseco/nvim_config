local function is_whitespace(line)
  return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
  for _, entry in ipairs(tbl) do
    if not check(entry) then
      return false
    end
  end
  return true
end
require('neoclip').setup({
	history = 500,
	filter = function(data)
    return not all(data.event.regcontents, is_whitespace)
  end,
	preview = true,
	default_register = '+',
	content_spec_column = true,
	on_paste = {
		set_reg = true,
	},
	keys = {
		telescope = {
			i = {
				-- select = '<cr>',
				paste = 'p',
				paste_behind = '<cr>',
				custom = {},
			},
			n = {
				-- select = '<cr>',
				paste = 'p',
				paste_behind = '<cr>',
				custom = {},
			},
		},
	},
})
vim.api.nvim_set_keymap('n', '<A-p>',  ":lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({initial_mode = 'normal'}))<CR><ESC>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-p>',  ":lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({initial_mode = 'normal'}))<CR><ESC>", {noremap = true, silent = true})

