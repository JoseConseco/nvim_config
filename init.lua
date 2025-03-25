-- _G.P = function(x)
--   print(vim.inspect(x))
-- end

require "plugins"
-- require "javelin".setup()
require "settings"
require "keymappings"

local timeday_theme_au = vim.api.nvim_create_augroup("TimedayThemeAu", { clear = true })

local function theme_change_timeday(start_hour, end_hour)
  local time = tonumber(vim.fn.strftime "%H")
  local current_theme = vim.g.colors_name

  if time < start_hour or time > end_hour then
    if current_theme ~= "nightfox" then
      vim.cmd.colorscheme "nightfox"
    end
  else
    if current_theme ~= "dayfox" then
      vim.cmd.colorscheme "dayfox"
    end
  end
end

-- Only create one autocmd for theme change
vim.api.nvim_create_autocmd({"VimEnter", "FocusGained"}, {
  group = timeday_theme_au,
  callback = function()
    theme_change_timeday(9, 13)
  end,
  once = true,  -- Ensures it runs only once
})

-- Initial theme setup
theme_change_timeday(9, 13)

  -- vim.cmd [[doautoall ColorScheme]] - why was here in old setup - very slow..


-- hide cursorline in inactive windows
local cursor_group = vim.api.nvim_create_augroup("MyCursorHideInactive", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  pattern = "*",
  callback = function()
    vim.o.cursorline = true
  end,
  group = cursor_group,
})
vim.api.nvim_create_autocmd("WinLeave", {
  pattern = "*",
  callback = function(opts)
    if vim.bo[opts.buf].filetype ~= "NvimTree" then
      vim.o.cursorline = false
    end
  end,
  group = cursor_group,
})


-- my other autocmds
local init_group = vim.api.nvim_create_augroup("MyInitAuGroup", { clear = true })
--remove white spaces on save and restore cursor pos - using mark '.'
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[let save_pos = getpos(".") | %s/\s\+$//e | call setpos(".", save_pos)]],
  group = init_group,
})

-- vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "TextYankPost", "WinEnter" }, {
-- --"TextChanged"
--   pattern = "*",
--   callback = function()
--     -- print("open fold")
--     local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
--     -- print("row: "..line_data[1])
--     local fold_closed = vim.fn.foldclosed(line_data[1]) -- -1 if no fold at line
--     print("closed: "..fold_closed)
--     if fold_closed < line_data[1] and fold_closed ~= -1 then --fold before cursor, and fold exist (not -1)
--       vim.cmd [[normal! zv]]
--     end
--   end,
--   group = init_group,
-- })

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
  group = init_group,
})

-- NOTE: fix nvim not maximized in allacritty
-- vim.cmd [[
-- 	autocmd VimEnter * :sleep 80m
-- 	autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
-- ]]

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "Todo", timeout = 100 }
  end,
  group = init_group,
})


-- -- fix cmd line suppressed messages on echo (cmp fault?)
-- -- see issue: https://github.com/gelguy/wilder.nvim/issues/41#issuecomment-860025867
-- vim.cmd [[
-- 	function! SetShortmessF(on) abort
-- 	  if a:on
-- 	    set shortmess+=F
-- 	  else
-- 	    set shortmess-=F
-- 	  endif
-- 	  return ''
-- 	endfunction
--
-- 	nnoremap <expr> : SetShortmessF(1) . ':'
--
-- 	augroup WilderShortmessFix
-- 	  autocmd!
-- 	  autocmd CmdlineLeave * call SetShortmessF(0)
-- 	augroup END
-- ]]
-- vim.cmd[[lua MiniStarter.open()]]  -- not sure why autoopen wont work... on hyprland

-- hack to make nvim-bqf preview work with stefandtw/quickfix-reflector.vim plug
-- local function t(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
-- vim.api.nvim_create_autocmd({"FileType" }, {
--   pattern = {"qf"},
--   callback = function()
--     vim.keymap.set("n", "j", function() vim.api.nvim_feedkeys(t("p<Down>p"),"m", true)  print('a') end, {noremap = true, silent = true, buffer=0})
--     vim.keymap.set("n", "k", function() vim.api.nvim_feedkeys(t("p<Up>p"),"m", true)  end, {noremap = true, silent = true, buffer=0})
--     -- vim.api.nvim_buf_set_keymap(0, "n", "k", [[<cmd>execute "normal! kpp"<cr>]], {noremap = true, silent = true})
--     return true -- finish au on first run
--   end,
-- })

