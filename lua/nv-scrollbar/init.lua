vim.g.scrollbar_shape = {
	head ='▎',
	body ='▎',
	tail ='▎',
}      --default █
vim.g.scrollbar_excluded_filetypes = {'nerdtree', 'tagbar'}
vim.g.scrollbar_right_offset = 1
vim.g.scrollbar_max_size = 10
vim.g.scrollbar_min_size = 3

-- vim.cmd([[
-- augroup your_config_scrollbar_nvim
-- 	autocmd!
-- 	autocmd BufEnter,CursorMoved,VimResized,FocusGained * silent! v:lua.require('scrollbar').show()
-- 	autocmd BufLeave,FocusLost,QuitPre  * silent! v:lua.require('scrollbar').clear()
-- augroup end
-- ]])
