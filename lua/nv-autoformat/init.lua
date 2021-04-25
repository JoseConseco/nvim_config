vim.g.formatdef_autopep8 = "'autopep8 - --ignore=E226,E24,W50,W690 --max-line-length=130 --range '.a:firstline.' '.a:lastline"
vim.g.formatters_python = {'autopep8', 'yapf', 'black' } -- order matters

vim.api.nvim_set_keymap( "n", "==", ":AutoformatLine<CR>", { noremap = true } )
vim.api.nvim_set_keymap( "v", "=", ":Autoformat<CR>", { noremap = true } )


