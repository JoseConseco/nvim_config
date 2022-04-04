local theme_change_au = vim.api.nvim_create_augroup("MyThemeChangeAu", { clear = true })

local dayfox_col = require("nightfox.palette").load "dayfox"
local dawnfox_col = require("nightfox.palette").load "dawnfox"
-- local dayfox_spec = require('nightfox.spec').load("nightfox")

require("nightfox").setup {
  options = {
    transparent = false,
    dim_inactive = true,
    styles = { -- Style to be applied to different syntax groups
      functions = "bold",
      keywords = "bold",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = true,
    },
  },
  palettes = {
    nightfox = {
      red = "#df6959",
      orange_br = "#e49464",
    },
    nordfox = {
      comment = "#60728a",
    },
    dayfox = {
      bg1 = "#f7f7f5", -- brighter
      cyan = "#208990", -- darker for args
    },
    dawnfox = {
			bg1 = "#FFFAF3", -- brighter
    },
  },
  specs = {
    dayfox = {
			syntax = {
				func = dayfox_col.blue.bright, -- was almost black
				conditional = dayfox_col.red.base, -- if, then etc
				operator = dayfox_col.red.base, -- for and, or etc - was black
				ident = dayfox_col.magenta.base,  -- cyan by default
				type = "#dd9024"  -- was too bright
			},
    },
		dawnfox = {
			syntax = {
				-- type = dawnfox_col.yellow.dark,
				type = "#dc9010", -- was too bright
			},
		}
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
