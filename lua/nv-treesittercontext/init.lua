require('treesitter-context.config').setup{enable = false,}
local hl_manager = require "hl_manager"
-- hl_manager.highlight_link("TreesitterContext", "PmenuSel")
hl_manager.highlight_from_src("TreesitterContext", "Normal", {action='contrast', factor=-11}) -- reduce contrast by default by -5

local ctx_toggle = vim.api.nvim_create_augroup("TSContextToggle", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", { pattern = "*", command = [[:TSContextDisable]], group = ctx_toggle, })
vim.api.nvim_create_autocmd("InsertLeave,BufEnter", { pattern = "*", command = [[:TSContextEnable]], group = ctx_toggle, })

