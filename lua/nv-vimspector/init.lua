vim.api.nvim_set_keymap('n','<F5>', ':call vimspector#Continue()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n','<S-F5>', ':call vimspector#Stop()<CR>', {noremap = true})


vim.api.nvim_set_keymap('n','<F6>', ':call vimspector#ToggleBreakpoint()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n','<S-F6>', ':call vimspector#ToggleConditionalBreakpoint()<CR>', {noremap = true})

vim.api.nvim_set_keymap('n','<F8>', ':call vimspector#StepOver()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n','<F7>', ':call vimspector#StepInto()<CR>', {noremap = true})
vim.api.nvim_set_keymap('n','<F9>', ':call vimspector#StepOut()<CR>', {noremap = true})
