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

--  add new empty line above/below current line in normal or vis mode (to give breathing space to code)
vim.api.nvim_set_keymap('n','<M-o>', ':let save_pos = getpos(".") | normal o<Esc> | :call setpos(".", save_pos)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n','<M-O>', ':let save_pos = getpos(".") | normal O<Esc> | :call setpos(".", [save_pos[0], save_pos[1]+1, save_pos[2], save_pos[3]])<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v','<M-o>', '<ESC> | :let save_pos = getpos(".") | normal \'>o<Esc> | :call setpos(".", save_pos)<CR> | gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v','<M-O>', '<ESC> | :let save_pos = getpos(".") | normal \'<O<Esc> | :call setpos(".", [save_pos[0], save_pos[1]+1, save_pos[2], save_pos[3]])<CR> | gv', {noremap = true, silent = true})

-- You can't stop me
vim.api.nvim_set_keymap('c', 'w!!', 'w !sudo tee %', {})

-- Alt+Shift+Up/Down to move lines up and down
vim.api.nvim_set_keymap('n', '<A-S-Down>', ':m .+1<CR>==', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-S-Up>', ':m .-2<CR>==',   { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==',    { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==',    { noremap = true, silent = true})

vim.api.nvim_set_keymap('i', '<A-S-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-S-Up>', '<Esc>:m .-2<CR>==gi',   { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi',    { noremap = true, silent = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi',    { noremap = true, silent = true})

vim.api.nvim_set_keymap('v', '<A-S-Down>', ':m \'>+1<CR>gv=gv', { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-S-Up>', ':m \'<-2<CR>gv=gv',   { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv',    { noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv',    { noremap = true, silent = true})


--  copy line/selection above or below current line in normal or vis mode
vim.api.nvim_set_keymap('n', '<S-A-j>',  ":.copy.<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<S-A-k>',    ":.copy.-1<Return>", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<S-A-j>',  ":'<,'>copy'<-1<Return>gv", {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<S-A-k>',    ":'<,'>copy'><Return>gv", {noremap = true, silent = true})

-- select block after indenting
vim.api.nvim_set_keymap('v', '<', '<gv', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '>', '>gv', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', '<', '<<_', {noremap = true})

-- jump backward
-- vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-o>', {noremap = true})
-- <Tab> is same as <C-i> - jumps forward -breaks auto comp
--
--
-- Use tab for indenting in visual mode -- !breaks jump forward (since ctrl+I == Tab in vim wtf)
-- vim.api.nvim_setmap('n', '<Tab>', '>gv|', {noremap = true})
-- vim.api.nvim_set_keymap('n', '<S-Tab>', '<gv', {noremap = true})
-- vim.api.nvim_set_keymap('n', '>', '>>_', {noremap = true})

-- smart up and down
vim.api.nvim_set_keymap('n', '<Down>', 'gj',{noremap = true})
vim.api.nvim_set_keymap('n', '<Up>', 'gk',{noremap = true})

--  Fast saving like normal humans with ctrl+s  :w - always, :up - only when file was changed
vim.api.nvim_set_keymap('n', '<C-s>', ':up<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<C-s>', ':uw<CR>gv', {noremap = true})
vim.api.nvim_set_keymap('c', '<C-s>', ':uw<CR>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:up<CR>', {noremap = true})

-- disable ctrl+z == suspend
vim.api.nvim_set_keymap('n', '<C-z>', 'u', {noremap = true})


-- vim.cmd([[call yankstack#setup()]]) --or else yank stack wont work with Y
-- 'normal' Backspace
vim.api.nvim_set_keymap('n', '<BS>', '"_X', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '<BS>', '"_x', {noremap = true})

-- X and x wont affect clipboard
vim.api.nvim_set_keymap('n', 'X', '"_X', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'x', '"_x', {noremap = true, silent = true})

-- D and d wont affect clipboard in visual
vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'dd', 'dd', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'D', '"_D', {noremap = true, silent = true})

-- delete without overriding register
vim.api.nvim_set_keymap('v', '<Del>',  '"_d', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Del>',  '"_x', {noremap = true, silent = true})

-- change without overriding register
-- vim.api.nvim_set_keymap('v', 'c',  '"_c', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'c',  '"_c', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', 'C',  '"_C', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'C',  '"_C', {noremap = true, silent = true})

-- substitute without overriding register
vim.api.nvim_set_keymap('v', 's',  '"_s', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 's',  '"_s', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'S',  '"_S', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'S',  '"_S', {noremap = true, silent = true})

-- paste without overriding register
vim.api.nvim_set_keymap('v', 'p',  '"_dp`[v`]', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'P',  '"_dP', {noremap = true, silent = true})

-- yank till end of line


-- no highlight
vim.api.nvim_set_keymap('n', '<C-h>', ':set hlsearch!<CR>', {noremap = true, silent = true})

-- auto magic search
vim.api.nvim_set_keymap('n', '/', '/\\v', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '/', '/\\v', {noremap = true})
vim.api.nvim_set_keymap('c', 's/', 's/\\v', {noremap = true})
vim.api.nvim_set_keymap('c', 'g/', 'g/\\v', {noremap = true})

-- search for selection whithout jump
vim.api.nvim_set_keymap('n', '*', "*zvzz", {noremap = true}) -- zv open fold; zz center on search result
vim.api.nvim_set_keymap('n', '#', "#zvzz", {noremap = true}) --bacwards,  zv open fold; zz center on search result
vim.api.nvim_set_keymap('v', '*', "y/\\V<C-R>=escape(@\",'/\')<CR>zvzz", {noremap = true})
vim.api.nvim_set_keymap('v', '#', "y?\\V<C-R>=escape(@\",'/\')<CR>zvzz", {noremap = true}) -- backward
-- vim.api.nvim_set_keymap('n', '*', ":keepjumps normal! mi*`i<CR>", {noremap = true})   -- wont affect jump list

-- substitute word under cursor with yanked text (+ register )
-- vim.api.nvim_set_keymap('v', '*s', "\"ay:%s/<C-r>a/<C-r>+/gc<CR>", {noremap = true}) -- \<word\>  -adds whitespace  word limit (sub only whole words)
-- vim.api.nvim_set_keymap('n', '*s', ":%s/\\<<C-r><C-w>\\>/<C-r>+/gc<CR>", {noremap = true})

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
-- vim.api.nvim_set_keymap( "n", "<F3>", ":MinimapToggle<CR>", { noremap = true, silent = true } )


-- NTree replacement
vim.api.nvim_set_keymap( "n", "<F4>", ":Fern . -drawer -reveal=% -toggle -width=35<CR>", { noremap = true, silent = true} )


--MM click to toggle folds under cursor(zA)
vim.api.nvim_set_keymap( "n", "<MiddleMouse>", "<LeftMouse>za", { noremap = true } )
vim.api.nvim_set_keymap( "n", "<2-MiddleMouse>", "<nop>", {} ) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap( "n", "<3-MiddleMouse>", "<nop>", {} ) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap( "n", "<4-MiddleMouse>", "<nop>", {} ) --and disable 2MMB so no accidental paste..

-- <C-r> - paste from specified register
vim.api.nvim_set_keymap("i", "<C-v>", '<C-r>+', { noremap = true } )
vim.api.nvim_set_keymap("c", "<C-v>", '<C-r>+', { noremap = true } )

-- Tab switch buffer
--vim.api.nvim_set_keymap('n', '<TAB>', ':bnext<CR>', {noremap = true, silent = true})
--vim.api.nvim_set_keymap('n', '<S-TAB>', ':bprevious<CR>', {noremap = true, silent = true})
-- bufferline tabs
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })

-- barbar plug
-- vim.api.nvim_set_keymap('n', '<TAB>', ':BufferNext<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<S-TAB>', ':BufferPrevious<CR>', { noremap = true, silent = true })

-- next/repve, join - prevent jumping of cursor
vim.api.nvim_set_keymap( "n", "n", "nzzzv", { noremap = true } )
vim.api.nvim_set_keymap( "n", "N", "Nzzzv", { noremap = true } )
vim.api.nvim_set_keymap( "n", "J", "mzJ'z", { noremap = true } )

--add breakpoint for undo at space, . and ,
vim.api.nvim_set_keymap( "i", " ", " <c-g>u", { noremap = true } )
vim.api.nvim_set_keymap( "i", ",", ",<c-g>u", { noremap = true } )
vim.api.nvim_set_keymap( "i", ".", ".<c-g>u", { noremap = true } )
