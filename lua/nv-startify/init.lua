vim.g.startify_custom_header = {
    '    ██████╗ ██████╗ ██████╗ ███████╗',
    '   ██╔════╝██╔═══██╗██╔══██╗██╔════╝',
    '   ██║     ██║   ██║██║  ██║█████╗',
    '   ██║     ██║   ██║██║  ██║██╔══╝',
    '   ╚██████╗╚██████╔╝██████╔╝███████╗',
    '    ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝'
}

vim.g.webdevicons_enable_startify = 1
vim.g.startify_enable_special = 0
vim.g.startify_files_number = 6
-- vim.g.startify_session_autoload = 1
vim.g.startify_session_delete_buffers = 1
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_session_persistence = 1  -- update sess on leaving vim, and loading new session (SLoad)
-- vim.g.startify_session_dir = '~/.local/share/nvim/session'


vim.g.startify_lists ={
	{type = 'commands', header  = nil,},
	{type = 'sessions',  header  = {'    Sessions',}},
	-- {type = 'files',     header  = {'    Files',}},
	{type = 'bookmarks', header  = {'    Bookmarks',}},
}

vim.g.startify_commands = {
	{ s = {'Sessions' ,  ":lua require'telescope'.extensions.sessions.sessions{}" }},
	{ r = {'Recent Files' ,  ':Telescope oldfiles' }},
	{ b = {'File Brower' ,  ':Telescope file_browser' }},
}

vim.g.startify_bookmarks = {
	{ a = '~/.config/blender/2.82/scripts/addons/' },
	{ z = '~/.local/share/nvim/site/pack/packer/start' },
}

