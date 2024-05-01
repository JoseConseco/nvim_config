-- simple bookmarking system
-- <leader><num> to go to a bookmark
-- <leader><leader><num> to set a bookmark

local config = {
  spear_count = 6,
  default_icon = "",
  icons = { "➊", "➋", "➌", "➍", "➎", "➏" },
}

---@type table<number, {bufnr: number, row: number, col: number}>
local bookmarks = {}

for i = 1, config.spear_count do
  local name = string.format("SpearBookmark%s", i)
  vim.fn.sign_define(name, {
    text = config.icons[i] or config.default_icon,
    texthl = "LineNr",
    culhl = "CursorLineSign",
    -- linehl = "",
    -- numhl = "",
  })
end

local remove_bookmark = function(index)
  if not bookmarks[index] then
    return
  end
  local bookmark = bookmarks[index]
  local sign = string.format("SpearBookmark%s", index)
  vim.fn.sign_unplace(sign, { buffer = bookmark.bufnr })
  bookmarks[index] = nil
end

local add_bookmark = function(index)
  local bufnr = vim.api.nvim_get_current_buf()
  local winnr = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(winnr))
  local prev_mapping = bookmarks[index]
  remove_bookmark(index)
  if prev_mapping and prev_mapping.bufnr == bufnr and prev_mapping.row == row and prev_mapping.col == col then
    return
  end
  bookmarks[index] = { bufnr = bufnr, row = row, col = col }
  local sign = string.format("SpearBookmark%s", index)
  vim.fn.sign_place(0, sign, sign, bufnr, { lnum = row })
end

local add_next_bookmark = function()
  for i = 1, config.spear_count do
    if not bookmarks[i] then
      add_bookmark(i)
      return
    end
  end
end

local remove_bookmark_for_buf = function(bufnr)
  for i = 1, config.spear_count do
    local bookmark = bookmarks[i]
    if bookmark and bookmark.bufnr == bufnr then
      remove_bookmark(i)
    end
  end
end

local remove_all_bookmarks = function()
  for i = 1, config.spear_count do
    remove_bookmark(i)
  end
end

local navigate = function(index)
  local bookmark = bookmarks[index]
  if bookmark then
    local current_bufnr = vim.api.nvim_get_current_buf()
    if current_bufnr == bookmark.bufnr then
      vim.api.nvim_win_set_cursor(0, { bookmark.row, bookmark.col })
    else
      vim.api.nvim_set_current_buf(bookmark.bufnr)
      vim.api.nvim_win_set_cursor(0, { bookmark.row, bookmark.col })
    end
  else -- if no bookmark, set one
    add_bookmark(index)
  end
end

local go_to_next_bookmark = function()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local current_row, current_col = unpack(vim.api.nvim_win_get_cursor(0))
  local next_index = nil
  for i = 1, config.spear_count do
    local bookmark = bookmarks[i]
    if bookmark and bookmark.bufnr == current_bufnr and (bookmark.row > current_row or (bookmark.row == current_row and bookmark.col > current_col)) then
      if not next_index or (bookmark.row < bookmarks[next_index].row or (bookmark.row == bookmarks[next_index].row and bookmark.col < bookmarks[next_index].col)) then
        next_index = i
      end
    end
  end
  if next_index then
    navigate(next_index)
  else -- wrap around
    for i = 1, config.spear_count do
      local bookmark = bookmarks[i]
      if bookmark and bookmark.bufnr == current_bufnr then
        navigate(i)
        return
      end
    end
  end
end

local go_to_previous_bookmark = function()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local current_row, current_col = unpack(vim.api.nvim_win_get_cursor(0))
  local next_index = nil
  for i = 1, config.spear_count do
    local bookmark = bookmarks[i]
    if bookmark and bookmark.bufnr == current_bufnr and (bookmark.row < current_row or (bookmark.row == current_row and bookmark.col < current_col)) then
      if not next_index or (bookmark.row > bookmarks[next_index].row or (bookmark.row == bookmarks[next_index].row and bookmark.col > bookmarks[next_index].col)) then
        next_index = i
      end
    end
  end
  if next_index then
    navigate(next_index)
  else -- wrap around
    for i = config.spear_count, 1, -1 do
      local bookmark = bookmarks[i]
      if bookmark and bookmark.bufnr == current_bufnr then
        navigate(i)
        return
      end
    end
  end
end

local setup = function()
  -- mappings
  for i = 1, config.spear_count do
    local key = string.format("m%s", i)
    vim.keymap.set("n", key, function()
      navigate(i)
    end, {
      noremap = true,
      silent = true,
      desc = string.format("Navigate to %s", i),
    })
  end

  vim.keymap.set("n", "mc", function()
    remove_all_bookmarks()
  end, { noremap = true, silent = true, desc = "Clear All Bookmarks" })

  vim.keymap.set("n", "mm", function()
    add_next_bookmark()
  end, { noremap = true, silent = true, desc = "Add Next Bookmark" })

  vim.keymap.set("n", "mn", function()
    go_to_next_bookmark()
  end, { noremap = true, silent = true, desc = "Go to Next Bookmark" })

  vim.keymap.set("n", "mp", function()
    go_to_previous_bookmark()
  end, { noremap = true, silent = true, desc = "Go to Next Bookmark" })

  for i = 1, config.spear_count do
    local key = string.format("mm%s", i)
    vim.keymap.set("n", key, function()
      add_bookmark(i)
    end, {
      noremap = true,
      silent = true,
      desc = string.format("Bookmark %s", i),
    })
  end

  -- autocommands
  vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(event)
      remove_bookmark_for_buf(event.buf)
    end,
  })
end

return {
  setup = setup,
}
