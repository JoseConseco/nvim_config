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

--  Start new line- break <Ret> in comd window...
-- vim.api.nvim_set_keymap('n','<Enter>', 'o<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n','<M-o>', 'o<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n','<M-O>', 'O<Esc>', {noremap = true})

-- You can't stop me
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee %', {})

-- Alt+Shift+Up/Down to move lines up and down
vim.api.nvim_set_keymap('n', '<A-S-Down>', ':m .+1<CR>==', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-S-Up>', ':m .-2<CR>==',   { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-S-j>', ':m .+1<CR>==',    { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-S-k>', ':m .-2<CR>==',    { noremap = true, silent = true})

vim.api.nvim_set_keymap('i', '<A-S-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-S-Up>', '<Esc>:m .-2<CR>==gi',   { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-S-j>', '<Esc>:m .+1<CR>==gi',    { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-S-k>', '<Esc>:m .-2<CR>==gi',    { noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<A-S-Down>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-S-Up>', ':m \'<-2<CR>gv=gv',   { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-S-j>', ':m \'>+1<CR>gv=gv',    { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-S-k>', ':m \'<-2<CR>gv=gv',    { noremap = true, silent = true})


-- Alt + j/k to duplicate up and down (alt does not work with Arrows !)
vim.api.nvim_set_keymap('n', '<A-j>',  ":.copy.<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>',    ":.copy.-1<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-j>',  ":'<,'>copy'<-1<Return>gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-k>',    ":'<,'>copy'><Return>gv", {noremap = true, silent = true})

-- select block after indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true})

-- jump backward
-- vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-o>', {noremap = true})
-- <Tab> is same as <C-i> - jumps forward -breaks auto comp
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

--  Fast saving  :w - always, :up - only when file was changed
vim.api.nvim_set_keymap('n', '<C-s>', ':up<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<C-s>', ':uw<CR>', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-s>', ':uw<CR>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:up<CR>', {noremap = true})




-- 'normal' Backspace
vim.api.nvim_set_keymap('n', '<BS>', '"_X', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<BS>', '"_x', {noremap = true})

-- X and x wont affect clipboard
vim.api.nvim_set_keymap('n', 'X', '"_X', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true, silent = true})

-- D and d wont affect clipboard in visual
vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'D', '"_D', {noremap = true, silent = true})

-- delete without overriding register
vim.api.nvim_set_keymap('v', '<Del>',  '"_d', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Del>',  '"_x', {noremap = true, silent = true})

-- change without overriding register
vim.api.nvim_set_keymap('v', 'c',  '"_c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'c',  '"_c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'C',  '"_C', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'C',  '"_C', {noremap = true, silent = true})

-- substitute without overriding register
vim.api.nvim_set_keymap('v', 's',  '"_s', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 's',  '"_s', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'S',  '"_S', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'S',  '"_S', {noremap = true, silent = true})

-- paste without overriding register
vim.api.nvim_set_keymap('v', 'p',  '"_dp', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'P',  '"_dP', {noremap = true, silent = true})


-- no highlight
vim.api.nvim_set_keymap('n', '<C-h>', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- auto magic search
vim.api.nvim_set_keymap('n', '/', '/\\v', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '/', '/\\v', {noremap = true})
vim.api.nvim_set_keymap('c', 's/', '%smagic/', {noremap = true})
vim.api.nvim_set_keymap('n', ':g/', ':g/\\v', {noremap = true})

-- scene.cursor
vim.api.nvim_set_keymap('v', '*', "y/\\V<C-R>=escape(@\",'/\')<CR><CR>", {noremap = true})

-- select all file...  % - all lines,
-- vim.api.nvim_set_keymap("n", "<C-a>", 'gg<S-v>G', {noremap = true})
-- vim.api.nvim_set_keymap("n", "<C-a>", [[ <Cmd> %y+<CR>]], {noremap = true})

--close all Folds remap
vim.api.nvim_set_keymap('n', 'zC',  'zM', {noremap = true, silent = true})

-- Hop plug
-- vim.api.nvim_set_keymap('n', '<A-s>',  ':HopChar2<Return>', {noremap = true, silent = true})

-- Fold All toggle
-- vim.api.nvim_set_keymap( "n", "<F1>",  vim.cmd([[&foldlevel:'zM'?'zR' ]]), { expr = true, noremap = true, silent = true } )
-- function _G.conditional_fold()  return vim.wo.foldlevel > 0 and 'zM' or 'zR' end
-- vim.api.nvim_set_keymap( "n", "<Leader>ff",  'v:lua.conditional_fold()',  { expr = true, noremap = true, silent = true } )


vim.api.nvim_set_keymap( "n", "<F1>",  ":lua require'telescope'.extensions.sessions.sessions{}<CR>",  {noremap = true, silent = true } )

-- File find under F2
vim.api.nvim_set_keymap( "n", "<F2>",  ':Telescope find_files<CR>',  {noremap = true, silent = true } )

-- Minimap
vim.api.nvim_set_keymap( "n", "<F3>", ":MinimapToggle<CR>", { noremap = true, silent = true } )


-- NTree replacement
vim.api.nvim_set_keymap( "n", "<F4>", ":Fern . -drawer -reveal=% -toggle -width=35<CR>", { noremap = true, silent = true} )


--MM click to toggle folds under cursor(zA)
vim.api.nvim_set_keymap( "n", "<MiddleMouse>", "<LeftMouse>za", { noremap = true } )
vim.api.nvim_set_keymap( "n", "<2-MiddleMouse>", "<nop>", {} ) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap( "n", "<3-MiddleMouse>", "<nop>", {} ) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap( "n", "<4-MiddleMouse>", "<nop>", {} ) --and disable 2MMB so no accidental paste..

-- <C-r> - paste from specified register
vim.api.nvim_set_keymap("i", "<C-v>", '<C-r>+', { noremap = true } ) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap("c", "<C-v>", '<C-r>+', { noremap = true } ) --and disable 2MMB so no accidental paste..

-- Tab switch buffer
--vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})
-- bufferline tabs
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })

-- barbar plug
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })
