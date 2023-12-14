local M = {}

local cmp = require("cmp")
local timer = vim.loop.new_timer()

M.DEBOUNCE_DELAY = 500

function M.debounce()
  timer:stop()
  timer:start(
    M.DEBOUNCE_DELAY,
    0,
    vim.schedule_wrap(function()
      -- cmp.complete({ reason = cmp.ContextReason.Auto })
      cmp.complete()

    end)
  )
end

return M
