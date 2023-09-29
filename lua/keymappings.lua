-- Mode Prefixes:
-- n  Normal mode map. Defined using ':nmap' or ':nnoremap'.
-- i  Insert mode map. Defined using ':imap' or ':inoremap'.
-- v  Visual and select mode map. Defined using ':vmap' or ':vnoremap'.
-- x  Visual mode map. Defined using ':xmap' or ':xnoremap'.
-- s  Select mode map. Defined using ':smap' or ':snoremap'.
-- c  Command-line mode map. Defined using ':cmap' or ':cnoremap'.
-- o  Operator pending mode map. Defined using ':omap' or ':onoremap'.

-- better go up or down
vim.api.nvim_set_keymap("n", "gg", "G", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "G", "gg", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "gg", "G", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "G", "gg", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "g%", ":normal! ggVG<cr>", { noremap = true, silent = true })

-- I hate escape
vim.api.nvim_set_keymap("i", "jk", "<ESC>zv", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', 'jj', '<ESC>zv', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('i', 'kk', '<ESC>zv', {noremap = true, silent = true})
vim.api.nvim_set_keymap("i", "<ESC>", "<ESC>zv", { noremap = true, silent = true })

-- when no wrap - move by visual lines
vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "j", "gj", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "k", "gk", { noremap = true, silent = true })

-- map ctrl + j,k,l,h - in inser move
vim.api.nvim_set_keymap("i", "<c-h>", "<left>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-l>", "<right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-j>", "<down>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-k>", "<up>", { noremap = true, silent = true })

--  add new empty line above/below current line in normal or vis mode (to give breathing space to code)
vim.api.nvim_set_keymap("n", "<M-o>", ':let save_pos = getpos(".") | normal o<Esc> | :call setpos(".", save_pos)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-O>", ':let save_pos = getpos(".") | normal O<Esc> | :call setpos(".", [save_pos[0], save_pos[1]+1, save_pos[2], save_pos[3]])<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<M-o>", '<ESC> | :let save_pos = getpos(".") | normal \'>o<Esc> | :call setpos(".", save_pos)<CR> | gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<M-O>", '<ESC> | :let save_pos = getpos(".") | normal \'<O<Esc> | :call setpos(".", [save_pos[0], save_pos[1]+1, save_pos[2], save_pos[3]])<CR> | gv', { noremap = true, silent = true })

-- You can't stop me
vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee %", {})

-- Alt+Shift+Up/Down to move lines up and down
vim.api.nvim_set_keymap("n", "<A-S-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-S-Up>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<A-S-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-S-Up>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "<A-S-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-S-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

--  copy line/selection above or below current line in normal or vis mode
vim.api.nvim_set_keymap("n", "<S-A-j>", ":.copy.<Return>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-A-k>", ":.copy.-1<Return>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-A-j>", ":'<,'>copy'<-1<Return>gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<S-A-k>", ":'<,'>copy'><Return>gv", { noremap = true, silent = true })

-- select block after indenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
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
vim.api.nvim_set_keymap("n", "<Down>", "gj", { noremap = true })
vim.api.nvim_set_keymap("n", "<Up>", "gk", { noremap = true })

--  Fast saving like normal humans with ctrl+s  :w - always, :up - only when file was changed
vim.api.nvim_set_keymap("n", "<C-s>", ":up!<CR>", { noremap = true })
vim.api.nvim_set_keymap("v", "<C-s>", "<esc>:up! | normal gv<cr>", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-s>", ":uw!<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:up!<CR>", { noremap = true })

-- disable ctrl+z == suspend
vim.api.nvim_set_keymap("n", "<C-z>", "u", { noremap = true })

-- vim.cmd([[call yankstack#setup()]]) --or else yank stack wont work with Y
-- 'normal' Backspace
vim.api.nvim_set_keymap("n", "<BS>", '"_X', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<BS>", '"_x', { noremap = true })

-- X and x wont affect clipboard
vim.api.nvim_set_keymap("n", "X", '"_X', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "x", '"_x', { noremap = true, silent = true })

-- do not override yank when deleting empty lines
local function delete_special()
  -- local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
  -- vim.pretty_print(line_data)
  -- local current_line = vim.api.nvim_buf_get_lines(0, line_data[1]-1, line_data[1], false)
  if vim.api.nvim_get_current_line():match "^%s*$" == "" then -- only white chars?
    return '"_dd'
  else
    return "dd"
  end
end
-- D and d wont affect clipboard in visual
-- vim.api.nvim_set_keymap('v', 'd', '"_d', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'd', '"_d', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'dd', 'dd', {noremap = true, silent = true})
vim.keymap.set("n", "dd", delete_special, { noremap = true, expr = true })

-- delete without overriding register
vim.api.nvim_set_keymap("v", "<Del>", '"_d', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Del>", '"_x', { noremap = true, silent = true })

-- substitute without overriding register
-- vim.api.nvim_set_keymap('v', 's',  '"_s', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 's',  '"_s', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('v', 'S',  '"_S', {noremap = true, silent = true})
-- vim.api.nvim_set_keymap('n', 'S',  '"_S', {noremap = true, silent = true})

-- change without overriding register - meh - cool as vim surround emulation
--[[ vim.api.nvim_set_keymap('v', 'c',  '"_c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'c',  '"_c', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'C',  '"_C', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'C',  '"_C', {noremap = true, silent = true}) ]]
-- paste without overriding register
vim.api.nvim_set_keymap("v", "p", "p`[v`]", { noremap = true, silent = true, desc = "Paste Select" })
vim.api.nvim_set_keymap("v", "P", "P`[v`]", { noremap = true, silent = true, desc = "Paste Select" })

-- <C-r> - paste from specified register
vim.api.nvim_set_keymap("i", "<C-v>", "<C-r>+", { noremap = true })
vim.api.nvim_set_keymap("c", "<C-v>", "<C-r>+", { noremap = true })

-- paste fast over cursor word
-- vim.api.nvim_set_keymap("n", " p", '<cmd>normal! viw"_d"0P<cr>', { noremap = true, desc = "Paste over word" } )
vim.api.nvim_set_keymap("n", " p", '<cmd>normal! viw"_dP<cr>', { noremap = true, desc = "Paste over word" })
vim.api.nvim_set_keymap("n", "gp", [==[`[v`]]==], { noremap = true })

-- no highlight
-- vim.api.nvim_set_keymap('n', '<m-h>', ':set hlsearch!<CR>', {noremap = true, silent = true})
--[[ vim.api.nvim_set_keymap('n', 'gh', '^', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gl', '$', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'gh', '^', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', 'gl', '$', {noremap = true, silent = true}) ]]
vim.keymap.set({ "n", "v", "o" }, "<c-h>", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "<c-l>", "$", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<m-h>", "<cmd>ISwapNodeWithLeft<CR>", { noremap = true, silent = true }) -- move sel forward one word
vim.api.nvim_set_keymap("n", "<m-l>", "<cmd>ISwapNodeWithRight<CR>", { noremap = true, silent = true }) -- move sel backward one word
-- vim.api.nvim_set_keymap('v', '<m-h>', "<cmd>normal xbP`[v`]'<cr>", {noremap = true, silent = true}) -- move sel forward one word
-- vim.api.nvim_set_keymap('v', '<m-l>', "<cmd>normal xep`]v`['<cr>", {noremap = true, silent = true}) -- move sel backward one word

-- auto magic search
--[[ vim.api.nvim_set_keymap('n', '/', '/\\v', {noremap = true, silent = true})
vim.api.nvim_set_keymap('v', '/', '/\\v', {noremap = true})
vim.api.nvim_set_keymap('c', 's/', 's/\\v', {noremap = true})
vim.api.nvim_set_keymap('c', 'g/', 'g/\\v', {noremap = true}) ]]
-- search for selection whithout jump  -- with "kevinhwang91/nvim-hlslens" support
-- [[ /\<<C-R>=expand('<cword>')<CR>\>\C<CR> ]] - makes * case sensitive always
vim.api.nvim_set_keymap("n", "*", [[<cmd>set hlsearch<cr>*zzzv]], { noremap = true }) -- zv open fold; zz center on search result
vim.api.nvim_set_keymap("n", "#", [[<cmd>set hlsearch<cr>#zzzv]], { noremap = true }) --bacwards,  zv open fold; zz center on search result
-- included in nvim since 8.0
vim.api.nvim_set_keymap("v", "*", [[<cmd>set hlsearch<cr>y/\V<C-R>=escape(@+,'/\')<CR><CR>zzzv]], { noremap = true })
vim.api.nvim_set_keymap("v", "#", [[<cmd>set hlsearch<cr>y?\V<C-R>=escape(@+,'/\')<CR><CR>zzzv]], { noremap = true }) -- backward
-- vim.api.nvim_set_keymap('n', '*', ":keepjumps normal! mi*`i<CR>", {noremap = true})   -- wont affect jump list

-- substitute word under cursor with yanked text (+ register )
-- vim.api.nvim_set_keymap('v', '*s', "\"ay:%s/<C-r>a/<C-r>+/gc<CR>", {noremap = true}) -- \<word\>  -adds whitespace  word limit (sub only whole words)
-- vim.api.nvim_set_keymap('n', '*s', ":%s/\\<<C-r><C-w>\\>/<C-r>+/gc<CR>", {noremap = true})

-- select all file...  % - all lines,
-- vim.api.nvim_set_keymap("n", "<C-a>", 'gg<S-v>G', {noremap = true})
-- vim.api.nvim_set_keymap("n", "<C-a>", [[ <Cmd> %y+<CR>]], {noremap = true})

-- Hop plug
-- vim.api.nvim_set_keymap('n', '<A-s>',  ':HopChar2<Return>', {noremap = true, silent = true})

-- Fold All toggle
-- vim.api.nvim_set_keymap( "n", "<F1>",  vim.cmd([[&foldlevel:'zM'?'zR' ]]), { expr = true, noremap = true, silent = true } )
-- function _G.conditional_fold()  return vim.wo.foldlevel > 0 and 'zM' or 'zR' end
-- vim.api.nvim_set_keymap( "n", "<Leader>ff",  'v:lua.conditional_fold()',  { expr = true, noremap = true, silent = true } )

--- use { "anuvyklack/windows.nvim",
vim.api.nvim_set_keymap("n", "<c-w>m", ":WindowsMaximize<CR>", { noremap = true, desc = "Maximize" })
vim.api.nvim_set_keymap("n", "<c-w>=", ":WindowsEqualize<CR>", { noremap = true, desc = "Equalize" })
vim.api.nvim_set_keymap("n", "<c-w>_", ":WindowsMaximizeVertically<CR>", { noremap = true, desc = "Maximize height" })
vim.api.nvim_set_keymap("n", "<c-w>|", ":WindowsMaximizeHorizontally<CR>", { noremap = true, desc = "Maximize width" })

vim.api.nvim_set_keymap("n", "<F1>", ":Telescope sessions_picker<CR>", { noremap = true, silent = true })

-- File find under F2
vim.api.nvim_set_keymap("n", "<F2>", ":Telescope find_files<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap( "n", "<F2>",  '::FzfLua files<CR>',  {noremap = true, silent = true } )
--switch to last buffer
vim.api.nvim_set_keymap("n", "<F10>", "<c-^>", { noremap = true, silent = true })

-- Minimap
-- vim.api.nvim_set_keymap( "n", "<F3>", ":MinimapToggle<CR>", { noremap = true, silent = true } )

-- NTree replacement
-- vim.api.nvim_set_keymap( "n", "<F4>", ":Fern . -drawer -reveal=% -toggle -width=35<CR>", { noremap = true, silent = true} )
-- vim.api.nvim_set_keymap( "n", "<F4>", "<Cmd>NnnPicker %:p:h<CR>", { noremap = true, silent = true} ) -- randomly wont work
vim.api.nvim_set_keymap("n", "<F4>", ":FloatermNew ranger<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "-", ":Oil --float<cr>", { noremap = true, silent = true })

--MM click to toggle folds under cursor(zA)
vim.api.nvim_set_keymap("n", "<MiddleMouse>", "<LeftMouse>za", { noremap = true })
vim.api.nvim_set_keymap("n", "<2-MiddleMouse>", "<nop>", {}) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap("n", "<3-MiddleMouse>", "<nop>", {}) --and disable 2MMB so no accidental paste..
vim.api.nvim_set_keymap("n", "<4-MiddleMouse>", "<nop>", {}) --and disable 2MMB so no accidental paste..

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
-- vim.api.nvim_set_keymap( "n", "n", "nzzzv", { noremap = true } )
-- vim.api.nvim_set_keymap( "n", "N", "Nzzzv", { noremap = true } )

vim.api.nvim_set_keymap("n", "J", "mzJ'z", { noremap = true })
vim.api.nvim_set_keymap("n", "<c-J>", "mq:s/\\v,\\s+/,\\r/g<cr>V'q=", { noremap = true })

-- repeat last ciw - on next word
vim.api.nvim_set_keymap("n", "g.", '/\\V<C-r>"<CR>cgn<C-a><Esc>', { noremap = true, desc = "Repeat ciw" })
vim.api.nvim_set_keymap("n", "cg*", '"zyiw*N"_cgn<C-R>z', { noremap = true, desc = "Change with repeat" }) -- with yank into z, and paste in insert mode
-- vim.api.nvim_set_keymap( "v", "cg*", "\"ay/\\V<C-R>=escape(@a,'/\')<CR><CR>N\"_cgn", { noremap = true, desc = "Change with repeat" } ) -- based on * visual remap
vim.api.nvim_set_keymap("v", "cg*", "\"ay/\\V<C-R>=escape(@a,'/')<CR><CR>N\"_cgn<C-R>=escape(@a,'/')<CR>", { noremap = true, desc = "Change with repeat" }) -- based on * visual remap

--add breakpoint for undo at space, . and ,
vim.api.nvim_set_keymap("i", " ", " <c-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ",", ",<c-g>u", { noremap = true })
vim.api.nvim_set_keymap("i", ".", ".<c-g>u", { noremap = true })

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local function open_sub_folds()
  local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
  -- vim.cmd [[IndentBlanklineRefresh]] -- from lukas-reineke/indent-blankline.nvim
  if vim.fn.foldclosed(line_data[1]) == -1 then -- not folded
    -- open sub folds
    return ":normal! zczO" .. t "<cr>" .. "<cr>" -- normal - prevets flicker
    -- return "zczO"
  else -- if fold - then open normall
    return ":normal! zO" .. t "<cr>" .. "<cr>" -- normal - prevets flicker
    -- return "zO"
  end
end

local function override_l_with_indent_refresh()
  local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
  if vim.fn.foldclosed(line_data[1]) ~= -1 then --  folded
    print "folded"
    vim.cmd [[normal! zo^]] -- from lukas-reineke/indent-blankline.nvim
    -- vim.cmd [[IndentBlanklineRefresh]] -- from lukas-reineke/indent-blankline.nvim
  else
    vim.cmd "normal! l"
  end
end

vim.keymap.set("n", "l", override_l_with_indent_refresh, { remap = true })
vim.keymap.set("n", "zo", "zo<cr>", { remap = false, desc = "zo with indentline refresh" })
vim.keymap.set("n", "zi", "zi<cr>", { remap = false, desc = "zi with indentline refresh" })
vim.keymap.set("n", "zx", "zxzM<cr>", { remap = false, desc = "zi with indentline refresh" })
vim.keymap.set("n", "zO", open_sub_folds, { remap = true, expr = true })

-- better subfodls
-- vim.keymap.set( "n", "zO", close_sub_folds, { remap = true, expr = true } )
-- vim.api.nvim_set_keymap('n', 'zC',  'zC:foldc!|normal! zo<cr>', {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "zC", ':execute "normal! zC" | foldc! | exe "normal! zv"<cr>', { noremap = true, silent = true }) -- close fold under cursor rec

--close all Folds remap

-- Saner behavior of n and N - plus added hlslens

vim.cmd [[
nnoremap <expr> n  'Nn'[v:searchforward].'zzzv'
xnoremap <expr> n  'Nn'[v:searchforward].'zzzv'
onoremap <expr> n  'Nn'[v:searchforward]

nnoremap <expr> N  'nN'[v:searchforward].'zzzv'
xnoremap <expr> N  'nN'[v:searchforward].'zzzv'
onoremap <expr> N  'nN'[v:searchforward]
]]
--
--
