vim.g.edge_style = 'default' -- neon, aura, default
vim.g.edge_disable_italic_comment = 0
vim.g.edge_enable_italic = 1
vim.g.edge_cursor = 'yellow' -- auto, red, green, cyan, blue, purple
vim.g.edge_sign_column_background = 'default' -- options: none, default
vim.g.edge_transparent_background = 0
vim.g.edge_menu_selection_background = 'purple' -- blue, green, purple
vim.g.edge_diagnostic_text_highlight = 0 --def 0
vim.g.edge_diagnostic_line_highlight = 0  -- def 0
vim.g.edge_diagnostic_virtual_text = 'grey' -- def 'grey' /  colored
vim.g.edge_current_word = 'underline' -- def =`'grey background'`, `'bold'`, `'underline'`, `'italic'


-- vim.cmd([[
-- function! s:edge_custom() abort
-- 		" Link a highlight group to a predefined highlight group.
-- 		" See `colors/edge.vim` for all predefined highlight groups.
-- 		highlight! link groupA groupB
-- 		highlight! link groupC groupD

-- 		" Initialize the color palette.
-- 		" The parameter is a valid value for `g:edge_style`,
-- 		let l:palette = edge#get_palette('aura')
-- 		" Define a highlight group.
-- 		" The first parameter is the name of a highlight group,
-- 		" the second parameter is the foreground color,
-- 		" the third parameter is the background color,
-- 		" the fourth parameter is for UI highlighting which is optional,
-- 		" and the last parameter is for `guisp` which is also optional.
-- 		" See `autoload/edge.vim` for the format of `l:palette`.
-- 		call edge#highlight('groupE', l:palette.red, l:palette.none, 'undercurl', l:palette.red)
-- 	endfunction

-- 	augroup EdgeCustom
-- 		autocmd!
-- 		autocmd ColorScheme edge call s:edge_custom()
-- 	augroup END
-- ]])
