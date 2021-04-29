-- Example config in Lua
vim.g.tokyonight_style = "storm"  -- night (darker) or storm
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_dark_sidebar = true  -- darken eg Fern, NerdTree etc
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer", "fern" }
vim.g.tokyonight_hide_inactive_statusline = true -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", } -- error = "#ff0000"
