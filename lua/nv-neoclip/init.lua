require('neoclip').setup()
vim.api.nvim_set_keymap('n', '<A-p>',  ":lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_cursor({initial_mode = 'normal'}))<CR>", {noremap = true, silent = true})

