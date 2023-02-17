-- require('mini.surround').setup({
-- 	n_lines = 10,
-- 	mappings = {
-- 		add = ' sa',           -- Add surrounding
-- 		delete = ' sd',        -- Delete surrounding
-- 		find = '',          -- Find surrounding (to the right)
-- 		find_left = '',     -- Find surrounding (to the left)
-- 		highlight = '',     -- Highlight surrounding  <Leader>ssh
-- 		replace = ' sr',       -- Replace surrounding
-- 		update_n_lines = ' ssn' -- Update `n_lines`
-- 	}
-- })

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
	autowrite = false,  -- done manually in my config

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
	{ name = 'Recent Files', action = ':Telescope frecency', section = 'Telescope' },
	{ name = 'Old Files', action = ':Telescope oldfiles', section = 'Telescope' },
	{ name = 'File Brower', action = ':Telescope file_browser', section = 'Telescope' },
	-- starter.sections.recent_files(10, false),
	-- starter.sections.recent_files(10, true),
	-- Use this if you set up 'mini.sessions'
	starter.sections.sessions(9, true),
	{ name = 'Addons', action = ':Oil ~/.config/blender/2.82/scripts/addons', section = 'Bookmarks' },
	{ name = 'NvimPlugs', action = ':Oil ~/.local/share/nvim/site/pack/packer/start', section = 'Bookmarks' },

}
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


-- require('mini.animate').setup()
-- local animate = require('mini.animate')
-- animate.setup({
-- -- Cursor path
--   cursor = {
--     -- Whether to enable this animation
--     enable = true,
--     timing = animate.gen_timing.linear({ duration = 80, unit = 'total' })
--   },
--   -- scroll = {
--   --   -- Animate for 200 milliseconds with linear easing
--   --   timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
--   --   -- Animate equally but with at most 120 steps instead of default 60
--   --   subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
--   -- }
-- })
local function sizes()
  vim.go.winwidth = math.max(120, math.floor(vim.go.columns * 0.61))
  vim.go.winminwidth = 10
  vim.go.winheight = math.max(30, math.floor(vim.go.lines * 0.61))
  vim.go.winminheight = 5
end

-- sizes()
-- vim.api.nvim_create_autocmd("VimResized", { callback = sizes })

-- vim.cmd[[set mousescroll=ver:25,hor:6]] -- compensate for slow the scroll animation




require('mini.bufremove').setup({})  -- ge delete buffer witout changing layout

-- require('mini.ai').setup({}) -- kind of ok, but does not handle spaces in args nice?
-- require('mini.jump').setup({
-- 	  mappings = {
-- 		    forward = 'f',
-- 		    backward = 'F',
-- 		    forward_till = 't',
-- 		    backward_till = 'T',
-- 		    repeat_jump = ';',
-- 		  },
--
-- 	  -- Delay values (in ms) for different functionalities. Set any of them to
-- 	  -- a very big number (like 10^7) to virtually disable.
-- 	  delay = {
-- 		    -- Delay between jump and highlighting all possible jumps
-- 		    highlight = 250,
--
-- 		    -- Delay between jump and automatic stop if idle (no jump is done)
-- 		    idle_stop = 2000,
-- 		  },
-- })
-- require('mini.jump2d').setup()
--
-- local function make_fFtT_keymap(key, extra_opts)
--   local opts = vim.tbl_deep_extend('force', { allowed_lines = { blank = false, fold = false } }, extra_opts)
--   opts.hooks = opts.hooks or {}
--
--   opts.hooks.before_start = function()
--     local input = vim.fn.getcharstr()
--     --stylua: ignore
--     if input == nil then
--       opts.spotter = function() return {} end
--     else
--       local pattern = vim.pesc(input)
--       opts.spotter = MiniJump2d.gen_pattern_spotter(pattern)
--     end
--   end
--
--   -- Using `<Cmd>...<CR>` enables dot-repeat in Operator-pending mode
--   _G.jump2dfFtT_opts = _G.jump2dfFtT_opts or {}
--   _G.jump2dfFtT_opts[key] = opts
--   local command = string.format('<Cmd>lua MiniJump2d.start(_G.jump2dfFtT_opts.%s)<CR>', key)
--
--   vim.api.nvim_set_keymap('n', key, command, {})
--   vim.api.nvim_set_keymap('v', key, command, {})
--   vim.api.nvim_set_keymap('o', key, command, {})
-- end
--
-- make_fFtT_keymap('f', { allowed_lines = { cursor_before = false } })
-- make_fFtT_keymap('F', { allowed_lines = { cursor_after = false } })
-- make_fFtT_keymap('t', {
--   allowed_lines = { cursor_before = false },
--   hooks = { after_jump = function() vim.api.nvim_input('<Left>') end },
-- })
-- make_fFtT_keymap('T', {
--   allowed_lines = { cursor_after = false },
--   hooks = { after_jump = function() vim.api.nvim_input('<Right>') end },
-- })
-- vim.api.nvim_set_keymap('x', 'A', 'aa', { noremap = false }) -- remap around functin to A
-- vim.api.nvim_set_keymap('o', 'A', 'aa', { noremap = false })
