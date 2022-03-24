require('mini.surround').setup({
	n_lines = 10,
	mappings = {
		add = ' sa',           -- Add surrounding
		delete = ' sd',        -- Delete surrounding
		find = '',          -- Find surrounding (to the right)
		find_left = '',     -- Find surrounding (to the left)
		highlight = '',     -- Highlight surrounding  <Leader>ssh
		replace = ' sr',       -- Replace surrounding
		update_n_lines = ' ssn' -- Update `n_lines`
	}
})

require('mini.comment').setup({
	-- Toggle comment (like `gcip` - comment inner paragraph) for both
	comment = 'gc', -- Normal and Visual modes
	comment_line = 'gcc', -- Toggle comment on current line
	textobject = 'gc', -- Define 'comment' textobject (like `dgc` - delete whole comment block)
})

require('mini.sessions').setup({
	-- Whether to read latest session if Neovim opened without file arguments
	autoread = false,

	-- Whether to write current session before quitting Neovim
	autowrite = false,

	-- Directory where global sessions are stored (use `''` to disable)
	directory = '/home/bartosz/.local/share/nvim/session',--<"session" subdir of user data directory from |stdpath()|>,

	-- File for local session (use `''` to disable)
	file = '',

	-- Whether to force possibly harmful actions (meaning depends on function)
	force = { read = false, write = true, delete = false },

	-- Whether to print session path after action
	verbose = { read = false, write = true, delete = true },
})





local starter = require('mini.starter')
local my_items = {
	starter.sections.builtin_actions(),
	{ name = 'Sessions', action = ":Telescope sessions_picker", section = 'Telescope' },
	{ name = 'Recent Files', action = ':Telescope oldfiles', section = 'Telescope' },
	{ name = 'File Brower', action = ':Telescope file_browser', section = 'Telescope' },
	-- starter.sections.recent_files(10, false),
	-- starter.sections.recent_files(10, true),
	-- Use this if you set up 'mini.sessions'
	starter.sections.sessions(9, true),
	{ name = 'Addons', action = ':Explore ~/.config/blender/2.82/scripts/addons', section = 'Bookmarks' },
	{ name = 'NvimPlugs', action = ':Explore ~/.local/share/nvim/site/pack/packer/start', section = 'Bookmarks' },

}
if vim.fn.exists('g:started_by_firenvim') ~= 1 then
	starter.setup({
		-- Whether to open starter buffer on VimEnter. Not opened if Neovim was
		-- started with intent to show something else.
		autoopen = true,

		-- Whether to evaluate action of single active item
		evaluate_single = true,

		-- Items to be displayed. Should be an array with the following elements:
		-- - Item: table with <action>, <name>, and <section> keys.
		-- - Function: should return one of these three categories.
		-- - Array: elements of these three types (i.e. item, array, function).
		-- If `nil` (default), default items will be used (see |mini.starter|).
		items = my_items,

		-- Header to be displayed before items. Should be a string or function
		-- evaluating to single string (use `\n` for new lines).
		-- If `nil` (default), polite greeting will be used.
		header = nil,

		-- Footer to be displayed after items. Should be a string or function
		-- evaluating to string. If `nil`, default usage help will be shown.
		footer = nil,


		-- Array  of functions to be applied consecutively to initial content.
		-- Each function should take and return content for 'Starter' buffer (see
		-- |mini.starter| for more details).
		content_hooks = {
			starter.gen_hook.adding_bullet(),
			starter.gen_hook.indexing('all', { 'Builtin actions', 'Telescope', 'Bookmarks'}),
			starter.gen_hook.padding(5, 2),
			starter.gen_hook.aligning('left', 'top'),
		},

		-- Characters to update query. Each character will have special buffer
		-- mapping overriding your global ones. Be careful to not add `:` as it
		-- allows you to go into command mode.
		query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-.]],
	})
end

