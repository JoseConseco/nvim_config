-- _G.P = function(x)
--   print(vim.inspect(x))
-- end

require "plugins"
require "hl_manager"
require "settings"
require "keymappings"
require "my_text_objects" -- repalced with mini.ai ...

local timeday_theme_au = vim.api.nvim_create_augroup("TimedayThemeAu", { clear = true })

-- remove auto_theme_change_ on manual ColorScheme event
local timeday_theme_change_finish_id = nil
local time_day_theme_auto = nil

local function timeday_theme_change_quit()
  timeday_theme_change_finish_id = vim.api.nvim_create_autocmd("ColorScheme", { -- will it work - may fire even on autocmd theme change...
    pattern = "*",
    callback = function()
      print("ColorScheme")
      vim.api.nvim_del_autocmd(time_day_theme_auto)
      timeday_theme_change_finish_id = nil
      return true -- finish this autocmd too
    end,
    group = timeday_theme_au,
  })
end
timeday_theme_change_quit()

-- why it wont load indentline even odd correctly?
local function theme_change_timeday(start_hour, end_hour)
  local time = tonumber(vim.fn.strftime "%H")
  local current_theme = vim.g.colors_name
  vim.api.nvim_del_autocmd(timeday_theme_change_finish_id) -- disable timeday_theme_change_finish_id
  if time < start_hour or time > end_hour then
    if current_theme ~= "nightfox" then
      -- print("Changing theme to nightfox")
      vim.cmd.colorscheme "nightfox"
    end
  else
    if current_theme ~= "dayfox" then
      -- print("Changing theme to dayfox")
      vim.cmd.colorscheme "dayfox"
    end
  end
  vim.cmd [[doautoall ColorScheme]]
  timeday_theme_change_quit()

end

time_day_theme_auto = vim.api.nvim_create_autocmd({"FocusGained" ,"FocusLost" }, {
  pattern = "*",
  callback = function()
    theme_change_timeday(9, 14)
  end,
  group = timeday_theme_au,
  -- nested = true, -- dow notwork in this case
})
theme_change_timeday(9, 14)



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

-- Auto cd to root dir -->               https://www.reddit.com/r/neovim/comments/zy5s0l/you_dont_need_vimrooter_usually_or_how_to_set_up/
-- Array of file names indicating root directory. Modify to your liking.
local root_names = { ".git", "Makefile" }

-- Cache to use for speed up (at cost of possibly outdated results)
local root_cache = {}

local set_root = function()
  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0) -- file name
  if path == "" then
    return
  end
  path = vim.fs.dirname(path) -- directory

  -- Try cache and resort to searching upward for root directory
  local root = root_cache[path]
  if root == nil then
    local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
    if root_file ~= nil then
      root = vim.fs.dirname(root_file)
      root_cache[path] = root
      -- else
      --   root = path
    end
  end
  -- Set current directory
  if vim.fn.isdirectory(root) == 1 then -- is valid?
    -- vim.fn.chdir(root)  -- sometimes changs window working dir, sometimes global...
    vim.cmd.cd(root) -- always change global working dir
    -- return true -- clear autocmd
  end
end

local root_augroup = vim.api.nvim_create_augroup("MyAutoRoot", {})
vim.api.nvim_create_autocmd("BufEnter", { group = root_augroup, callback = set_root })

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
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
vim.api.nvim_create_autocmd({"FileType" }, {
  pattern = {"qf"},
  callback = function()
    vim.keymap.set("n", "j", function() vim.api.nvim_feedkeys(t("p<Down>p"),"m", true)  print('a') end, {noremap = true, silent = true, buffer=0})
    vim.keymap.set("n", "k", function() vim.api.nvim_feedkeys(t("p<Up>p"),"m", true)  end, {noremap = true, silent = true, buffer=0})
    -- vim.api.nvim_buf_set_keymap(0, "n", "k", [[<cmd>execute "normal! kpp"<cr>]], {noremap = true, silent = true})
    return true -- finish au on first run
  end,
})

