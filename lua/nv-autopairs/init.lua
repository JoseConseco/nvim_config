-- finally good autopari
require('nvim-autopairs').setup({
	gpairs_map = {
		["'"] = "'",
		['"'] = '"',
		['('] = ')',
		['['] = ']',
		['{'] = '}',
		['`'] = '`',
	},
	disable_filetype = { "TelescopePrompt" },
	gbreak_line_filetype = nil, -- mean all file type
	ghtml_break_line_filetype = {'html' , 'vue' , 'typescriptreact' , 'svelte' , 'javascriptreact'},
	gignored_next_char = "%w",
})
