local ts_config = require("nvim-treesitter.configs")

ts_config.setup {
    ensure_installed = {
        "html",
        "css",
		"javascript",
        "bash",
        "python",
		"json",
		"jsonc",
		"c",
		"cpp",
		"c_sharp",
		"regex",
		"yaml",
		"java",
        "lua"
    },
    highlight = {
        enable = true,
        use_languagetree = true
    },
	indent = {enable = true},
    -- playground = {
    --     enable = true,
    --     disable = {},
    --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    --     persist_queries = false -- Whether the query persists across vim sessions
    -- },
	autotag = {enable = true},
	rainbow = { -- for  windwp/nvim-autopairs
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 2000, -- Do not enable for files with more than 1000 lines, int
  },
	autopairs = {enable = true}, -- for windwp/nvim-autopairs plug
	refactor = {
	    highlight_definitions = { enable = true }, --from treesitter-refactor
			highlight_current_scope = { enable = false },
	  },
}

-- vim.treesitter.query.set_query('python', 'folds', "(function_definition (block) @fold)")
-- print(require("nvim-treesitter").query.get_query('python', 'folds'))

-- require("nvim-treesitter").queries.python.
vim.wo.foldmethod="expr"
vim.wo.foldexpr="nvim_treesitter#foldexpr()"    -- o will give errors...
vim.wo.foldenable=false --do notenable fold at start
