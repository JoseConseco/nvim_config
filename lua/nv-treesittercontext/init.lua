require("treesitter-context").setup {
  enable = true,
  max_lines = 5,
  min_window_height = 25,
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}
local hl_manager = require "hl_manager"
-- hl_manager.highlight_link("TreesitterContext", "PmenuSel")
hl_manager.highlight_from_src("TreesitterContext", "Normal", { bg = -11 }) -- reduce contrast by default by -5

local ctx_toggle = vim.api.nvim_create_augroup("TSContextToggle", { clear = true })

-- vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = [[:TSContextDisable]], group = ctx_toggle, })
-- why below is super slow..
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   pattern = "*",
--   callback = function()
--     local function start_up_func()
--       vim.cmd [[TSContextEnable]]
--     end
--     vim.schedule(start_up_func) -- run after the buffer is loaded
--   end,
--   group = ctx_toggle })
