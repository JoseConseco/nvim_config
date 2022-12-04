local gtp = require "goto-preview"
local select_to_edit_map = {
  default = "edit",
  horizontal = "above new",
  vertical = "vnew",
  tab = "tabedit",
}

local function open_file(orig_window, filename, cursor_position, command)
  if orig_window ~= 0 and orig_window ~= nil then
    vim.api.nvim_set_current_win(orig_window)
  end
  if filename ~= nil then
    pcall(vim.cmd, string.format("%s %s", command, filename))
  else
    pcall(vim.cmd, string.format("normal %s", command))
  end
  vim.api.nvim_win_set_cursor(0, cursor_position)
end

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- define movement keys
local move_keys = { "<c-w>l", "<c-w>h", "<c-w>k", "<c-w>j" }
local function unload_keys()
  local buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_del_keymap(buffer, "n", "<C-v>")
  vim.api.nvim_buf_del_keymap(buffer, "n", "<CR>")
  vim.api.nvim_buf_del_keymap(buffer, "n", "<C-s>")
  vim.api.nvim_buf_del_keymap(buffer, "n", "<C-t>")
  vim.api.nvim_buf_del_keymap(buffer, "n", "q")
  for _, key in ipairs(move_keys) do
    vim.api.nvim_buf_del_keymap(buffer, "n", key)
  end
end

local function open_preview(preview_win, type)
  return function()
    unload_keys()
    local command = select_to_edit_map[type]
    local orig_window = vim.api.nvim_win_get_config(preview_win).win
    local cursor_position = vim.api.nvim_win_get_cursor(preview_win)
    local filename = vim.api.nvim_buf_get_name(0)

    vim.api.nvim_win_close(preview_win, gtp.conf.force_close)
    open_file(orig_window, filename, cursor_position, command)
  end
end

local function close_preview(preview_win)
  return function()
    unload_keys()
    vim.api.nvim_win_close(preview_win, gtp.conf.force_close)
  end
end

local function move_preview(preview_win, key)
  return function()
    unload_keys()
    local orig_window = vim.api.nvim_win_get_config(preview_win).win
    local cursor_position = vim.api.nvim_win_get_cursor(preview_win)
    local filename = vim.api.nvim_buf_get_name(0)
    vim.api.nvim_win_close(preview_win, gtp.conf.force_close)
    -- vim.api.nvim_feedkeys(t('<c-w>k'), 'n', false) -- swap with adjacent win (horizontal or vertical)
    vim.cmd(string.format([[exe "normal! \%s"]], key))
    pcall(vim.cmd, string.format("edit %s", filename)) -- replace adjacet buffer content with current buffer
    vim.api.nvim_win_set_cursor(0, cursor_position)
    vim.cmd.foldopen()
    vim.api.nvim_win_set_cursor(0, { cursor_position[1] + 1, cursor_position[2] })
    vim.cmd.foldopen()
    vim.api.nvim_win_set_cursor(0, cursor_position)
  end
  -- vim.cmd[[exe "normal! \<c-w>x"]]
  -- vim.api.nvim_feedkeys(t('<c-w>x'), 'n', false) -- swap with adjacent win (horizontal or vertical)
end

local function post_open_hook(buf, win)
  vim.keymap.set("n", "<C-v>", open_preview(win, "vertical"), { buffer = buf })
  vim.keymap.set("n", "<CR>", open_preview(win, "default"), { buffer = buf })
  vim.keymap.set("n", "<C-s>", open_preview(win, "horizontal"), { buffer = buf })
  vim.keymap.set("n", "<C-t>", open_preview(win, "tab"), { buffer = buf })
  vim.keymap.set("n", "q", close_preview(win), { buffer = buf, noremap = true, silent = true })
  vim.keymap.set("n", "<C-w>q", close_preview(win), { buffer = buf, noremap = true, silent = true })
  for _, key in ipairs(move_keys) do
    vim.keymap.set("n", key, move_preview(win, key), { buffer = buf, noremap = true, silent = true })
  end
end

require("goto-preview").setup {
  post_open_hook = post_open_hook,
}
vim.api.nvim_set_keymap("n", "gD", ':lua require("goto-preview").goto_preview_definition()<CR>', { noremap = true, silent = true, desc = "Goto preview definition" })
