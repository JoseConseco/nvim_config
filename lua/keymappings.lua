-- Mode Prefixes:
-- n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
-- i  Insert mode map. Defined using ':imap' or ':inoremap'.
-- v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
-- x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
-- s  Select mode map. Defined using ':smap' or ':snoremap'.
-- c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
-- o  Operator pending mode map. Defined using ':omap' or ':onoremap'.

-- I hate escape
vim.api.nvim_set_keymap('i', 'jk', '<ESC>', {noremap = true, silent = true})

--  Start new line
vim.api.nvim_set_keymap('n','<Enter>', 'o<Esc>', {noremap = true})

-- You can't stop me
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee %', {})

-- Alt+Shift+Up/Down to move lines up and down
vim.api.nvim_set_keymap('n', '<A-S-Down>', ':m .+1<CR>==', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-S-Up>', ':m .-2<CR>==', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-S-j>', ':m .+1<CR>==', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-S-k>', ':m .-2<CR>==', {noremap = true, silent = true})

vim.api.nvim_set_keymap('i', '<A-S-Down>', '<Esc>:m .+1<CR>==gi', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-S-Up>', '<Esc>:m .-2<CR>==gi', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-S-j>', '<Esc>:m .+1<CR>==gi', {noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-S-k>', '<Esc>:m .-2<CR>==gi', {noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<A-S-Down>', ':m \'>+1<CR>gv=gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-S-Up>', ':m \'<-2<CR>gv=gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-S-j>', ':m \'>+1<CR>gv=gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-S-k>', ':m \'<-2<CR>gv=gv', {noremap = true, silent = true})


-- Alt+Up/Down to duplicate up and down or Alt + j/k
vim.api.nvim_set_keymap('n', '<A-Down>',  ":.copy.<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-Up>',    ":.copy.<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-Down>',  ":'<,'>copy'><Return>gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-Up>',    ":'<,'>copy'><Return>gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-j>',  ":.copy.<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>',    ":.copy.<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-j>',  ":'<,'>copy'><Return>gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-k>',    ":'<,'>copy'><Return>gv", {noremap = true, silent = true})

-- select block after indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})

-- jump backward
vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-o>', {noremap = true})
-- <Tab> is same as <C-i> - jumps forward
--
--
-- Use tab for indenting in visual mode -- !breaks jump forward (since ctrl+I == Tab in vim wtf)
-- vim.api.nvim_setmap('n', '<Tab>', '>gv|', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<S-Tab>', '<gv', {noremap = true})
-- vim.api.nvim_set_keymap('n', '>', '>>_', {noremap = true})
vim.api.nvim_set_keymap('n', '<', '<<_', {noremap = true})

-- smart up and down
vim.api.nvim_set_keymap('n', '<Down>', 'gj',{noremap = true})
vim.api.nvim_set_keymap('n', '<Up>', 'gk',{noremap = true})

--  Fast saving
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<C-s>', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-s>', ':w<CR>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:w<CR>', {noremap = true})

-- 'normal' Backspace
vim.api.nvim_set_keymap('n', '<BS>', '"_X', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<BS>', '"_x', {noremap = true})

-- X and x wont affect clipboard
vim.api.nvim_set_keymap('n', 'X', '"_X', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true, silent = true})

-- delete without overriding register
vim.api.nvim_set_keymap('v', '<Del>',  '"_d', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Del>',  '"_x', {noremap = true, silent = true})

-- no hl
vim.api.nvim_set_keymap('n', '<C-h>', ':set hlsearch!<CR>', {noremap = true, silent = true})


-- Tab switch buffer
-- vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})

-- select all file...  % - all lines,
-- vim.api.nvim_set_keymap("n", "<C-a>", 'gg<S-v>G', {noremap = true})
-- vim.api.nvim_set_keymap("n", "<C-a>", [[ <Cmd> %y+<CR>]], {noremap = true})

--close all Folds remap
vim.api.nvim_set_keymap('n', 'zC',  'zM', {noremap = true, silent = true})

-- Hop plug
vim.api.nvim_set_keymap('n', '<A-s>',  ':HopChar2<Return>', {noremap = true, silent = true})

-- NVimTree
-- vim.api.nvim_set_keymap( "n", "<F3>", ":NvimTreeToggle<CR>", { noremap = true, silent = true } )
vim.api.nvim_set_keymap( "n", "<F3>", ":NERDTreeMirror<CR>:NERDTreeToggle<CR>", { noremap = true, silent = true } )

-- Minimap
vim.api.nvim_set_keymap( "n", "<F4>", ":MinimapToggle<CR>", { noremap = true, silent = true } )

-- Fold All toggle
-- vim.api.nvim_set_keymap( "n", "<F2>",  vim.cmd([[&foldlevel:'zM'?'zR' ]]), { expr = true, noremap = true, silent = true } )
function _G.conditional_fold()  return vim.wo.foldlevel > 0 and 'zM' or 'zR' end
vim.api.nvim_set_keymap( "n", "<F2>",  'v:lua.conditional_fold()',  { expr = true, noremap = true, silent = true } )

--MM click to toggle folds recursize under cursor(zA)
vim.api.nvim_set_keymap( "n", "<MiddleMouse>", "<LeftMouse>zA", { noremap = true } )
vim.api.nvim_set_keymap( "n", "<2-MiddleMouse>", "<nop>", { noremap = true } ) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap( "n", "<3-MiddleMouse>", "<nop>", { noremap = true } ) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap( "n", "<4-MiddleMouse>", "<nop>", { noremap = true } ) --and disable 2MMB so no accidental paste..

-- Tab switch buffer
--vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})
-- bufferline tabs
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })

-- barbar plug
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
