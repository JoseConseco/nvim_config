-- vim.wo.colorcolumn = "99999" -- fixes indentline - ugly higligts on folded code...

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
    char = "│",
		space_char_blankline = " ",
		-- show_current_context = true,
    -- show_current_context_start = true,
    char_highlight_list = {
        "IndentBlanklineContextChar",
    },
    space_char_highlight_list = {
        "IndentOdd",
        "IndentEven",
    },
    show_trailing_blankline_indent = false,
}
