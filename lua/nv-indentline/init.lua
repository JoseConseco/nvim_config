-- vim.wo.colorcolumn = "99999" -- fixes indentline - ugly higligts on folded code...

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")

local highlight = {
    "RainbowYellow",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowCyan",
    "RainbowViolet",
    "RainbowRed",
    "RainbowBlue",
}


-- local hl_manager = require "hl_manager"
-- hl_manager.highlight_from_src("IndentEven", "Normal", { bg = -6 }) -- reduce contrast by default by -5
-- vim.cmd [[highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine]]
-- -- hl_manager.highlight_from_src("IndentBlanklineContextChar", "Normal", {action='contrast', factor=-10}) -- reduce contrast by default by -5
-- -- vim.cmd [[highlight! link IndentBlanklineContextChar Comment]]
-- hl_manager.highlight_link("IndentBlanklineContextChar", "Comment")

-- local hooks = require "ibl.hooks"
-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
-- end)
vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })

local hl_manager = require "hl_manager"
hl_manager.match_color_to_highlight("#df717a", "conceal", "RainbowRed", "foreground")
hl_manager.match_color_to_highlight("#ebcb8b", "conceal", "RainbowYellow", "foreground")
hl_manager.match_color_to_highlight("#d08770", "conceal", "RainbowOrange", "foreground")
hl_manager.match_color_to_highlight("#a3be8c", "conceal", "RainbowGreen", "foreground")
hl_manager.match_color_to_highlight("#b48ead", "conceal", "RainbowViolet", "foreground")
hl_manager.match_color_to_highlight("#88c0d0", "conceal", "RainbowCyan", "foreground")
hl_manager.match_color_to_highlight("#6ea1ec", "conceal", "RainbowBlue", "foreground")


require("ibl").setup {
  indent = { highlight = highlight },
  scope = { enabled = false },
}
-- require("ibl").setup {
--   indent = { highlight = highlight, char = "" },
--   whitespace = {
--     highlight = highlight,
--     remove_blankline_trail = false,
--   },
--   scope = { enabled = false },
--   char = "│",
--
--   -- space_char_blankline = " ",
--   -- -- show_current_context = true,
--   --   -- show_current_context_start = true,
--   --   char_highlight_list = {
--   --       "IndentBlanklineContextChar",
--   --   },
--   --   space_char_highlight_list = {
--   --       "IndentOdd",
--   --       "IndentEven",
--   --   },
--   --   show_trailing_blankline_indent = false,
-- }
