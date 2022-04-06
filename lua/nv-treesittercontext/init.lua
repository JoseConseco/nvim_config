require('treesitter-context.config').setup{enable = false,}
local hl_adjust = require "hl_adjust"
-- hl_adjust.highlight_link("TreesitterContext", "PmenuSel")
hl_adjust.highlight_adjust_col("TreesitterContext", "Normal", {action='contrast', factor=-11}) -- reduce contrast by default by -5

local ctx_toggle = vim.api.nvim_create_augroup("TSContextToggle", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = [[:TSContextDisable]], group = ctx_toggle, })
vim.api.nvim_create_autocmd("InsertLeave,BufEnter", { pattern = "*", command = [[:TSContextEnable]], group = ctx_toggle, })

