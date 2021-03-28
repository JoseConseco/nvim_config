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
    }
}
