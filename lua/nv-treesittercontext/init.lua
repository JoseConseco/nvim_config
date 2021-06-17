require('treesitter-context.config').setup{enable = false,}
vim.api.nvim_exec('highlight link TreesitterContext PmenuSel', false)

vim.cmd([[
augroup TSContextToggle
	    " Clear the autocmds of the current group to prevent them from piling
	    " up each time you reload your vimrc.
	    autocmd!

	    " This autocmd calls 'MyFunction()' everytime Vim tries to create/edit
	    " a buffer tied to a file in /'path/to/project/**/'.
	    autocmd InsertEnter * :TSContextDisable
	    autocmd InsertLeave,BufEnter * :TSContextEnable
 augroup END
]])
