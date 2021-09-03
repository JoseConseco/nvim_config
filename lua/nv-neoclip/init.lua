require('neoclip').setup({
      history = 500,
      filter = nil,
      preview = true,
      default_register = '+',
      content_spec_column = false,
      on_paste = {
        set_reg = false,
      },
      keys = {
        i = {  paste_behind = '<cr>', },
        n = {  paste = 'p', paste_behind = '<cr>'},
      },
    })
vim.api.nvim_set_keymap('n', '<A-p>',  ":lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({initial_mode = 'normal', previewer = false,}))<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-p>',  ":lua require('telescope').extensions.neoclip.default(require('telescope.themes').get_dropdown({initial_mode = 'normal', previewer = false,}))<CR>", {noremap = true, silent = true})

