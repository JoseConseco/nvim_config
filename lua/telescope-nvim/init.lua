local fb_actions = require "telescope._extensions.file_browser.actions"
local actions = require "telescope.actions"

require("telescope").setup {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case"
		},
		-- prompt_position = "top",
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		border = {},
		-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		borderchars = {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
				prompt_position = "top"
				-- preview_width = 0.65
			},
			vertical = {
				mirror = false
			}
		},
		file_sorter = require "telescope.sorters".get_fuzzy_file,
		file_ignore_patterns = {"__cache__/.*", "%.pyc" },
		generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
		-- shorten_path = true,
		winblend = 0,
		color_devicons = true,
		use_less = true,
		path_display = {'smart'},
		set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
		file_previewer = require "telescope.previewers".vim_buffer_cat.new,
		grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
		qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
	},
	extensions = {
		media_files = {
			filetypes = {"png", "webp", "jpg", "jpeg"},
			find_cmd = "rg" -- find command (defaults to `fd`)
		},
		sessions_picker = {
			sessions_dir = vim.fn.stdpath('data') ..'/session/',
		},
		file_browser = {
			grouped = true,
			sorting_strategy = 'ascending',
			mappings = {
				["n"] = {
					["a"] = fb_actions.create,
					["c"] = fb_actions.create,
					["r"] = fb_actions.rename,
					["m"] = fb_actions.move,
					["y"] = fb_actions.copy,
					["d"] = fb_actions.remove,
					["x"] = fb_actions.remove,
					["o"] = fb_actions.open,
					["h"] = fb_actions.goto_parent_dir,
					["e"] = fb_actions.goto_home_dir,
					["w"] = fb_actions.goto_cwd,
					["t"] = fb_actions.change_cwd,
					["b"] = fb_actions.toggle_browser,
					["H"] = fb_actions.toggle_hidden,
					["s"] = fb_actions.toggle_all,
					-- ["l"] = vim.api.nvim_feedkeys('<CR>'),
					["l"] = actions.select_default,
				},
			},
		}

	}
}
local hl_adjust = require "hl_adjust"
hl_adjust.highlight_link('TelescopePromptNormal', 'Normal')
hl_adjust.highlight_link('TelescopePromptBorder', 'Normal')
hl_adjust.highlight_link('TelescopePromptPrefix', 'Normal')

hl_adjust.highlight_link('TelescopePreviewTitle', 'Search')
hl_adjust.highlight_link('TelescopePromptTitle', 'Search')
hl_adjust.highlight_link('TelescopeResultsTitle', 'Search')

hl_adjust.highlight_adjust_col("TelescopeBorder", "Normal", { action = "contrast", factor = -2 })
hl_adjust.highlight_link('TelescopeNormal', 'TelescopeBorder')
hl_adjust.highlight_link('TelescopeMatching', 'TelescopeBorder')

-- vim.cmd [[highlight! link TelescopeBorder Normal]]
-- vim.cmd [[highlight! link TelescopePromptNormal Normal]]
-- vim.cmd [[highlight! link TelescopePromptPrefix Normal]]
-- TelescopeBorder = { fg = "${bg_popup}", bg = "${bg_popup}" },
-- TelescopePromptBorder = { fg = "${bg_visual}", bg = "${bg_visual}" },
-- TelescopePromptNormal = { fg = "${fg_sidebar}", bg = "${bg_visual}" },
-- TelescopePromptPrefix = { fg = "${fg_sidebar}", bg = "${bg_visual}" },
-- TelescopeNormal = { fg = "${fg_sidebar}", bg = "${bg_popup}" },
-- TelescopePreviewTitle = { fg = "${bg_popup}", bg = "${green}" },
-- TelescopePromptTitle = { fg = "${bg_popup}", bg = "${green}" },
-- TelescopeResultsTitle = { fg = "${bg_popup}", bg = "${green}" },
-- TelescopeMatching = { fg = "${error}", bg = "${NONE}" },

require("telescope").load_extension("fzf")  -- from 'nvim-telescope/telescope-fzf-native.nvim'
require("telescope").load_extension("media_files")
require('telescope').load_extension('vim_bookmarks')
require('telescope').load_extension('aerial')
require("telescope").load_extension "file_browser"
require("telescope").load_extension "sessions_picker"
-- require('telescope').load_extension('projects')

-- local opt = {noremap = true, silent = true}
-- mappings
-- vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
-- vim.api.nvim_set_keymap( "n", "<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)

