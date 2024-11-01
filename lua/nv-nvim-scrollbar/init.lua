-- define black highlight with transparent background
require("scrollbar").setup({
    show = true,
    show_in_active_only = true,
    set_highlights = true,
    folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
    max_lines = false, -- disables if no. of lines in buffer exceeds this
    handle = {
        text = "▌",
        color = 'NONE',
        -- color = nil,
        cterm = nil,
        highlight = "Normal",
        hide_if_all_visible = true, -- Hides handle if all lines are visible
    },
    marks = {
        Search = {
            text = { "━", "⚌" },
            priority = 0,
            color = nil,
            cterm = nil,
            highlight = "Search",
        },
        Error = {
            text = { "━", "⚌" },
            priority = 1,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextError",
        },
        Warn = {
            text = { "━", "⚌" },
            priority = 2,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextWarn",
        },
        Info = {
            text = { "━", "⚌" },
            priority = 3,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextInfo",
        },
        Hint = {
            text = { "━", "⚌" },
            priority = 4,
            color = nil,
            cterm = nil,
            highlight = "DiagnosticVirtualTextHint",
        },
        Misc = {
            text = { "━", "⚌" },
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "Normal",
        },
        GitAdd = {
            text = "▎",
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "CustomSignsAdd",
        },
        GitChange = {
            text = "▎",
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "CustomSignsChange",
        },
        GitDelete = {
            text = "▎",
            priority = 5,
            color = nil,
            cterm = nil,
            highlight = "CustomSignsDelete",
        },
    },
    excluded_buftypes = {
        "terminal",
    },
    excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
    },
    autocmd = {
        render = {
            "BufWinEnter",
            "TabEnter",
            "TermEnter",
            "WinEnter",
            "CmdwinLeave",
            "TextChanged",
            "VimResized",
            "WinScrolled",
        },
        clear = {
            "BufWinLeave",
            "TabLeave",
            "TermLeave",
            "WinLeave",
        },
    },
    handlers = {
        diagnostic = false,
        search = true, -- Requires hlslens to be loaded
        gitsigns = false, -- Requires gitsigns.nvim
    },
})

