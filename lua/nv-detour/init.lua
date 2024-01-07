local function close_on_leave()
  local attached_bufnr = vim.api.nvim_get_current_buf()
  local attached_winid = vim.api.nvim_get_current_win()
  -- vim.bo.bufhidden = 'delete' -- close the terminal when window closes
  -- I am not entirely sure if there is any benefit to having this augroup
  local test_au = vim.api.nvim_create_augroup("DetourClose", { clear = true })

  vim.api.nvim_create_autocmd({ "WinEnter" }, {
    buffer = attached_bufnr,
    callback = function()
      print "Detour leave"
      -- check if current window is floating. If it is, skip closing detur window
      local winid = vim.api.nvim_get_current_win()
      if vim.api.nvim_win_get_config(winid).relative ~= "" or winid == attached_winid then
        return
      end
      vim.api.nvim_win_close(attached_winid, true)
      -- this autocmd only needs to return once so make sure you return true so it deletes itself after running.
      return true
    end,
    group = test_au,
    -- this nested attribute is actually needed at the moment or breaks the plugin's assumptions.
    -- I need to update the plugin so it doesn't depend on users remembering to setting the nested attribute.
    nested = true,
  })
end

vim.keymap.set("n", "<c-w><enter>", function()
  require("detour").Detour() -- Open a detour popup
  close_on_leave()
end)
vim.keymap.set("n", "gD", function()
  require("detour").DetourCurrentWindow() -- Open a detour popup
  close_on_leave()
  -- vim.bo.bufhidden = 'delete' -- delete this scratch buffer when we move out of it
  require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})

end)

