local snacks = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = true },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { -- not as smooth as karb94/neoscroll.nvim
      enabled = false,
      animate = {
        duration = { step = 15, total = 250 },
        easing = "outQuad",
      },
    },
    statuscolumn = { enabled = true },
    words = { enabled = false },
  },
}

-- local M = {}
-- table.insert(M, snacks)
return snacks
