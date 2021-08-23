-- vim.g.indent_blankline_buftype_exclude = {'terminal'}
-- vim.g.indent_blankline_filetype_exclude = {'help', 'startify', 'dashboard', 'packer', 'neogitstatus'}
-- vim.g.indent_blankline_char = '│' --'▏'
-- -- let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
-- vim.g.indent_blankline_use_treesitter = true
-- vim.g.indent_blankline_show_trailing_blankline_indent = false
-- vim.g.indent_blankline_show_current_context = true
-- -- vim.cmd([[highlight IndentBlanklineContextChar guifg=#706070 gui=nocombine]])
-- -- vim.cmd([[highlight! link IndentBlanklineContextChar Comment]])
-- -- vim.g.indent_blankline_context_patterns = {
-- --     'class', 'return', 'function', 'method', '^if', '^while', 'jsx_element', '^for', '^object', '^table', 'block',
-- --     'arguments', 'if_statement', 'else_clause', 'jsx_element',  'try_statement',
-- --     'catch_clause', 'import_statement', 'operation_type'
-- -- }

-- vim.g.indent_blankline_context_patterns = {'class', 'function', 'method',  'while', 'for'} -- 'if',

-- prevent colorchemes from clearing colors
vim.cmd([[
augroup IndentBlanklineContextAutogroup
    autocmd!
    autocmd ColorScheme * highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine
	  autocmd ColorScheme * highlight IndentEven guifg=NONE guibg=#263040 gui=nocombine
	  autocmd ColorScheme * highlight! link IndentBlanklineContextChar Comment
augroup END
]])
-- tokyonight
--[[ vim.cmd([[
augroup IndentBlanklineContextAutogroup
    autocmd!
    autocmd ColorScheme * highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine
	  autocmd ColorScheme * highlight IndentEven guifg=NONE guibg=#2c314b gui=nocombine
	  autocmd ColorScheme * highlight! link IndentBlanklineContextChar Comment
augroup END
]]--) ]]

vim.cmd [[highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine]]
vim.cmd [[highlight IndentEven guifg=NONE guibg=#2c3144 gui=nocombine]]
-- and then use the highlight groups
vim.g.indent_blankline_char_highlight_list = {"IndentBlanklineContextChar"}
vim.g.indent_blankline_space_char_highlight_list = {"IndentOdd", "IndentEven"}

-- don't show any characters
vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_space_char = " "

-- when using background, the trailing indent is not needed / looks wrong
vim.g.indent_blankline_show_trailing_blankline_indent = false

vim.wo.colorcolumn = "99999" -- fixes indentline - ugly higligts on folded code...

