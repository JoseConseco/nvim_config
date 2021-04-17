vim.g.scrollbar_shape = {
	head ='▎',
	body ='▎',
	tail ='▎',
}      --default █
vim.g.scrollbar_excluded_filetypes = {'nerdtree', 'tagbar'}
vim.g.scrollbar_right_offset = 1
vim.g.scrollbar_max_size = 10
vim.g.scrollbar_min_size = 3

vim.api.nvim_exec([[
augroup your_config_scrollbar_nvim
	autocmd!
	autocmd BufEnter,CursorMoved,VimResized,FocusGained * silent! lua require('scrollbar').show()
	autocmd BufLeave,FocusLost,QuitPre  * silent! lua require('scrollbar').clear()
augroup end
]], false)
