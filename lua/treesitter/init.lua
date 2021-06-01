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
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "+",
			scope_incremental = "grc",
			node_decremental = "-",
		},
	},
	autopairs = {enable = true}, -- for windwp/nvim-autopairs plug
	refactor = {
		highlight_definitions = { enable = true }, --from treesitter-refactor
		highlight_current_scope = { enable = false },
	},
	textobjects = { -- uses 'nvim-treesitter/nvim-treesitter-refactor'
		select = {
			enable = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["ic"] = "@conditional.inner",
				["ac"] = "@conditional.outer",
				["ib"] = "@block.inner",
				["ab"] = "@block.outer",
				["ip"] = "@parameter.inner",
				["ap"] = "@parameter.outer",
				-- Or you can define your own textobjects like this
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]c"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]C"] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[C"] = "@class.outer",
			},
		},
	},
}

-- vim.treesitter.query.set_query('python', 'folds', "(function_definition (block) @fold)")
-- print(require("nvim-treesitter").query.get_query('python', 'folds'))

-- require("nvim-treesitter").queries.python.
vim.wo.foldmethod="expr"
vim.wo.foldexpr="nvim_treesitter#foldexpr()"    -- o will give errors...
vim.wo.foldenable=true --do notenable fold at start


vim.api.nvim_set_keymap('n', '+',  ':normal v+<cr>', {noremap = true, silent = true}) -- + will now switch to normal and  grow selection from treesitter

