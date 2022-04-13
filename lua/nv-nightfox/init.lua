local dayfox_col = require("nightfox.palette").load "dayfox"
local nightfox_col = require("nightfox.palette").load "nightfox"
local dawnfox_col = require("nightfox.palette").load "dawnfox"
-- local dayfox_spec = require('nightfox.spec').load("nightfox")

require("nightfox").setup {
  options = {
    transparent = false,
    dim_inactive = true,
    styles = { -- Style to be applied to different syntax groups
      functions = "bold",
      keywords = "bold",
      conditional = "italic",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = true,
      search = true,
    },
  },
  palettes = {
    nightfox = {
      red = { base = "#df6959", bright = "#df6959", dim = "#df6959" },
      orange_br = "#e49464",
    },
    nordfox = {
      comment = "#60728a",
    },
    dayfox = {
      white = { base = "#ee9310", bright = "#f19615", dim = "#d38305" },

      bg0 = "#dfdfdf", -- Dark bg (status line and float)
      bg1 = "#F7F7FA", -- Default bg
      bg2 = "#dce1e8", -- Lighter bg (cursor line)
      bg3 = "#ebecec", -- Lighter bg (colorcolm folds)
      bg4 = "#dcdcdc", -- Conceal, border fg

      sel0 = "#eeefef", -- Popup bg, visual selection bg
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
        func = dayfox_col.blue.bright, -- was blue.dim
        conditional = dayfox_col.red.base, -- if, then etc
        -- operator = dayfox_col.red.base, -- for and, or etc - was black
        ident = dayfox_col.magenta.base, -- cyan by default
      },
    },
    dawnfox = {
      syntax = {
        func = dawnfox_col.blue.bright, -- was blue.dim
        conditional = dawnfox_col.red.base, -- if, then etc
        -- operator = dawnfox_col.red.base, -- for and, or etc - was black
      },
    },
    nightfox = {
      syntax = {
        func = nightfox_col.blue.bright, -- was blue.dim
        conditional = nightfox_col.red.base, -- if, then etc
      },
    },
  },
  groups = {
    -- Conditional = { fg = "syntax.builtin0", style = "bold" },
    Conditional = { link = "TSKeywordFunction" },
    TSKeywordOperator = { link = "TSKeywordFunction" },
    -- Operator = { link = "TSKeywordFunction" },

    -- TelescopeBorder = { link = "NormalFloat" },
    -- TelescopePromptBorder = { link = "Folded" },
    -- TelescopePromptNormal = {link = "Folded"},
    -- TelescopePromptPrefix = {link = "Folded"},
    -- TelescopeNormal = { link = "NormalFloat" },
    -- TelescopePreviewTitle = { link = "Search" },
    -- TelescopePromptTitle = { link = "Search" },
    -- TelescopeResultsTitle = { link = "Search"},
    -- TelescopeMatching = { link = "PmenuSel"},
  },
}
vim.cmd [[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]]
local hl_manager = require "hl_manager"
hl_manager.highlight_from_src("NormalNC", "Normal", { action = "contrast", factor = -5 })
-- local theme_change_au = vim.api.nvim_create_augroup("MyThemeChangeAu", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[set winhighlight=Normal:Normal,NormalNC:NormalNC]]
  end,
  -- group = theme_change_au,
})

-- hlgroups = { HopNextKey = {}, HopNextKey1 = {}, HopNextKey2 = { fg = "${blue}" }, HopUnmatched = {} },

-- vim.cmd [[ hi ActiveWindow guibg=#182534
-- 	hi InactiveWindow guibg=#242a39
-- 	set winhighlight=Normal:Normal,NormalNC:NormalNC]]
