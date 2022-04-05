local theme_change_au = vim.api.nvim_create_augroup("MyThemeChangeAu", { clear = true })

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
      visual = false,
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
      bg1 = "#F7F7FA", -- brighter
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
        operator = dayfox_col.red.base, -- for and, or etc - was black
        ident = dayfox_col.magenta.base, -- cyan by default
      },
    },
    dawnfox = {
      syntax = {
        func = dawnfox_col.blue.bright, -- was blue.dim
        conditional = dawnfox_col.red.base, -- if, then etc
        operator = dawnfox_col.red.base, -- for and, or etc - was black
      },
    },
    nightfox = {
      syntax = {
        func = nightfox_col.blue.bright, -- was blue.dim
        conditional = nightfox_col.red.base, -- if, then etc
        operator = nightfox_col.red.base, -- for and, or etc - was black
      },
    },
  },
  groups = {
    -- Conditional = { fg = "syntax.builtin0", style = "bold" },
    Conditional = { link = "TSKeywordFunction" },
    Operator = { link = "TSKeywordFunction" },
  },
}
vim.cmd [[highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00 ]]
vim.api.nvim_create_autocmd("ColorScheme, UIEnter", {
  pattern = "*",
  callback = function()
    local hl_adjust = require "hl_adjust"
    hl_adjust.highlight_adjust_col("NormalNC", "Normal", { action = "contrast", factor = -5 })
    vim.cmd [[set winhighlight=Normal:Normal,NormalNC:NormalNC]]
  end,
  group = theme_change_au,
})

-- hlgroups = { HopNextKey = {}, HopNextKey1 = {}, HopNextKey2 = { fg = "${blue}" }, HopUnmatched = {} },

-- vim.cmd [[ hi ActiveWindow guibg=#182534
-- 	hi InactiveWindow guibg=#242a39
-- 	set winhighlight=Normal:Normal,NormalNC:NormalNC]]
