require('gitsigns').setup {
signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '+', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '!', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,
		['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  },
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
  use_decoration_api = true
}
