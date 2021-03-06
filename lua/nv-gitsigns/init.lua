vim.api.nvim_exec([[
augroup MyColors
	autocmd!
	autocmd ColorScheme * highlight CustomSignsAdd guifg=#a4cf69 | highlight CustomSignsChange guifg=#63c1e6 | highlight CustomSignsDelete guifg=#d74f56
augroup END
]], false)

vim.cmd([[:highlight CustomSignsAdd guifg=#a4cf69]])
vim.cmd([[:highlight CustomSignsChange guifg=#63c1e6]])
vim.cmd([[:highlight CustomSignsDelete guifg=#d74f56]])
require('gitsigns').setup {
signs = {
    add          = {hl = 'CustomSignsAdd'   , text = '▍', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'}, --before fold
    change       = {hl = 'CustomSignsChange', text = '▍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'CustomSignsDelete', text = '▍', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'CustomSignsDelete', text = '▍', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'CustomSignsChange', text = '▍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    -- add          = {hl = 'GitSignsAdd'   , text = '▍', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'}, --before fold
    -- change       = {hl = 'GitSignsChange', text = '▍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    -- delete       = {hl = 'GitSignsDelete', text = '▍', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    -- topdelete    = {hl = 'GitSignsDelete', text = '▍', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    -- changedelete = {hl = 'GitSignsChange', text = '▍', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		fold         = {enable = true, hl = 'GitSignsFold'  , text = '▋', numhl='GitSignsFoldNr'  , linehl='GitSignsFoldLn' },
  },       -- narrower ▎  , ┋, ［
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,
    buffer = true,
		['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		['n <leader>ghn'] = '<cmd>lua require\"gitsigns\".next_hunk()<CR>',
  },
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
  use_decoration_api = true,
	use_internal_diff = true,  -- If luajit is present
}
