require("nightfox").setup({
  options = {
    transparent = false,
    -- dim_inactive = true,
    styles = { -- Style to be applied to different syntax groups
      functions = "bold",
      keywords = "bold",
      conditional = "italic",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = true,
    },
  },
  palettes = {
    nightfox = {
      red = { base = "#df6959", bright = "#df6959", dim = "#df6959" },
      sel0 = "#284263", -- Popup bg, visual selection bg
      orange_br = "#e49464",
    },
    nordfox = {
      comment = "#60728a",
    },
    dayfox = {
      white = { base = "#ee9310", bright = "#f19615", dim = "#d38305" },

      bg0 = "#dfdfdf", -- Dark bg (status line and float)
      bg1 = "#F7F7FA", -- Default bg
      bg2 = "#E8E8EC", -- Lighter bg (colorcolm folds)
      bg3 = "#DbEAfB", -- Lighter bg (cursor line)
      bg4 = "#dcdcdc", -- Conceal, border fg

      sel0 = "#D8E7fB", -- Popup bg, visual selection bg
      sel1 = "#dcdcdc", -- Popup sel bg, search bg
      cyan = { base = "#208990", bright = "#259495", dim = "#107980" }, -- darken
    },
    dawnfox = {
      bg1 = "#FFFAF3", -- brighter
      bg2 = "#eae1e3", -- brighter
      yellow = { base = "#ee9310", bright = "#f19615", dim = "#d38305" },
    },
  },
  specs = {
    dayfox = {
      syntax = {
        func = "blue.bright", -- was blue.dim
        ident = "magenta", -- cyan by default
      },
    },
    dawnfox = {
      syntax = {
        func = "palette.blue.bright", -- was blue.dim
      },
    },
    nightfox = {
      syntax = {
        func = "blue.bright", -- was blue.dim
      },
    },
  },
  groups = {
		all = {
			Conditional = { link = "TSKeywordFunction" },
			TSKeywordOperator = { link = "TSKeywordFunction" }, -- eg. for x `in` y
		}
  },
})
vim.cmd [[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]]
local hl_manager = require "hl_manager"
hl_manager.highlight_from_src("NormalNC", "Normal", {bg = -5})
hl_manager.match_hl_to_highlight("VertSplit", "Normal", {bg = -5}) -- just use bg colr from normal
hl_manager.match_hl_to_highlight("WinBarNC", "Normal", {fg = -14, bg = -5})
hl_manager.match_hl_to_highlight("WinBar", "Normal", {fg = -14, bg = -5})

-- local theme_change_au = vim.api.nvim_create_augroup("MyThemeChangeAu", { clear = true })

-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     vim.cmd [[set winhighlight=Normal:Normal,NormalNC:NormalNC]]
--   end,
--   -- group = theme_change_au,
-- })


-- hlgroups = { HopNextKey = {}, HopNextKey1 = {}, HopNextKey2 = { fg = "${blue}" }, HopUnmatched = {} },

-- vim.cmd [[ hi ActiveWindow guibg=#182534
-- 	hi InactiveWindow guibg=#242a39
-- 	set winhighlight=Normal:Normal,NormalNC:NormalNC]]
