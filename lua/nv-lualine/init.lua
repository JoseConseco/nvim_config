local gps = require("nvim-gps")

local colors = {
	bg = "#282c34",
	line_bg = "#282c34",
	fg = "#D8DEE9",
	fg_green = "#65a380",
	yellow = "#A3BE8C",
	cyan = "#22262C",
	darkblue = "#61afef",
	green = "#BBE67E",
	orange = "#FF8800",
	purple = "#252930",
	magenta = "#c678dd",
	blue = "#22262C",
	red = "#DF8890",
	lightbg = "#3C4048",
	nord = "#81A1C1",
	greenYel = "#EBCB8B"
}

local function get_cwd()
	-- local full_dir = vim.fn.expand('%:p') -- full file path
	-- http://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers
	local project_dir = vim.fn.getcwd()
	-- local project_dir = vim.fn.expand("%:p:~") - abs file path with ~/ format
	-- local home_dir = os.getenv("HOME")
	-- local abs_file_path = vim.fn.expand("%:p") -- #str - length -- relative path to pdir (or absolute smtim)
	local rel_file_dir = vim.fn.expand("%:p:~:.") -- #str - length -- relative path to pdir (or absolute smtim)

	-- project_dir = project_dir:gsub(home_dir, '~')
	-- project_dir = vim.fn.expand("%:p:h")
	-- project_dir = project_dir:gsub('(%w)[%w|%s|_]*','%1.')..'> '
	if #project_dir > 15 then
		local cut_idx = #project_dir - project_dir:reverse():find('/') + 1
		if cut_idx then
			project_dir ="."..project_dir:sub(cut_idx, -1)..'//'  -- show only last 25 digits
		else
			project_dir ="."..project_dir:sub(-10, -1)..'//'
		end
	else
		project_dir = project_dir..'/'
	end

	return project_dir..rel_file_dir.." "
end

require'lualine'.setup {
	options = {
		icons_enabled = true,
		theme = 'auto',
		component_separators = { left = '', right = '❰'}, -- left = '❱'
		section_separators = { left = '', right = ''},
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {{'mode',color={gui='bold'}}},
		lualine_b = {},
		lualine_c = {
			{'filetype', icon_only=true},
			get_cwd,
			-- {'filename', path=1},
			{gps.get_location, cond = gps.is_available, color={fg=colors.green}}
		},
		lualine_x = {}, -- 'encoding'
		lualine_y = {'branch', 'diff',
			-- {'diagnostics', sources={'nvim_lsp'}}},
			{'diagnostics', sources = {'nvim_diagnostic'}}
		},
		lualine_z = {'progress'}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}
}
