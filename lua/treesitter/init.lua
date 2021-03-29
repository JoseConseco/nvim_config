local ts_config = require("nvim-treesitter.configs")

ts_config.setup {
    ensure_installed = {
        "html",
        "css",
        "bash",
        "python",
        "lua"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    },
	indent = {enable = true},
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false -- Whether the query persists across vim sessions
    },
    autotag = {enable = true},
    rainbow = {enable = true},
}
