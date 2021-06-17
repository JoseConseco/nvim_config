
vim.api.nvim_set_keymap('n', '<a-p>',  '<plug>(YoinkPostPasteSwapBack)', {silent = true})
vim.api.nvim_set_keymap('n', '<a-P>',  '<plug>(YoinkPostPasteSwapForward)', {silent = true})
vim.api.nvim_set_keymap('n', 'p',  '<plug>(YoinkPaste_p)', {silent = true})
vim.api.nvim_set_keymap('n', 'P',  '<plug>(YoinkPaste_P)', { silent = true})
-- Also replace the default gp with yoink paste so we can toggle paste in this case too
vim.api.nvim_set_keymap('n', 'gp',  '<plug>(YoinkPaste_gp)', {silent = true})
vim.api.nvim_set_keymap('n', 'gP',  '<plug>(YoinkPaste_gP)', {silent = true})

-- cursor position will not change after performing a yank
vim.api.nvim_set_keymap('n', 'y',  '<plug>(YoinkYankPreserveCursorPosition)', {silent = true})
vim.api.nvim_set_keymap('x', 'y',  '<plug>(YoinkYankPreserveCursorPosition)', {silent = true})

vim.g.yoinkSyncNumberedRegisters = true
vim.g.yoinkAutoFormatPaste = false
vim.g.yoinkMoveCursorToEndOfPaste = true
vim.g.yoinkIncludeNamedRegisters = false
