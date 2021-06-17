vim.g.dap_virtual_text = 'all frames' -- 'all frames' or true or false
-- vim.cmd([[:highlight link NvimDapVirtualText Type]]) -- to give higlight Type instaed of Comment
vim.fn.sign_define('DapBreakpoint', {text='🔵', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🔴', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapLogPoint', {text='🚩', texthl='', linehl='', numhl=''})
-- require('dap-python').setup('~/.local/lib/python3.9/site-packages/') -- from vim-dap-python
require('dap-python').setup('/usr/bin/python') -- from vim-dap-python


vim.api.nvim_set_keymap('n','<F5>', ":lua require'dap'.continue()<CR>", {noremap = true})
-- vim.api.nvim_set_keymap('n','<S-F5>', ":call vimspector#Stop()<CR>", {noremap = true})


vim.api.nvim_set_keymap('n','<F6>', ":lua require'dap'.toggle_breakpoint()<CR>", {noremap = true})
vim.api.nvim_set_keymap('n','<S-F6>', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {noremap = true})

vim.api.nvim_set_keymap('n','<F8>', ":lua require'dap'.step_over()<CR>", {noremap = true})
vim.api.nvim_set_keymap('n','<F7>', ":lua require'dap'.step_into()<CR>", {noremap = true})
vim.api.nvim_set_keymap('n','<F9>', ":lua require'dap'.step_out()<CR>", {noremap = true})
