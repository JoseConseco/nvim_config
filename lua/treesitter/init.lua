local ts_config = require "nvim-treesitter.configs"

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
    "lua",
  },
  highlight = {
    enable = true,
    disable = { "comment" },
    use_languagetree = true,
  },
  indent = { enable = true },
  -- playground = {
  --     enable = true,
  --     disable = {},
  --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  --     persist_queries = false -- Whether the query persists across vim sessions
  -- },
  autotag = { enable = true },
  rainbow = { -- for  p00f/nvim-ts-rainbow
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 3000, -- Do not enable for files with more than n lines, int
    colors = {
      "#ebcb8b",
      "#a3be8c",
      "#88c0d0",
      "#6ea1ec",
      "#b48ead",
      "#df717a",
      "#d08770",
    },
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
  autopairs = { enable = true }, -- for windwp/nvim-autopairs plug
  matchup = { -- for andymass/vim-matchup
    enable = true, -- mandatory, false will disable the whole extension
    disable = { "ruby" }, -- optional, list of language that will be disabled
  },
	-- markid = { enable = true }, -- for		use 'David-Kunz/markid'
  textobjects = { -- uses 'nvim-treesitter/nvim-treesitter-refactor'
		select = {
			enable = false,
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
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]C"] = "@class.outer",
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
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()" -- o will give errors...
vim.wo.foldenable = true --do notenable fold at start

vim.api.nvim_set_keymap("n", "+", ":normal v+<cr>", { noremap = true, silent = true }) -- + will now switch to normal and  grow selection from treesitter
if require("nvim-treesitter.parsers").has_parser "python" then
  local folds_query = [[
(function_definition (block) @fold)
(class_definition (block) @fold)

(while_statement (block) @fold)
(for_statement (block) @fold)
(if_statement (block) @fold)
(with_statement (block) @fold)
(try_statement (block) @fold)

[
  (import_from_statement)
  (parameters)
  (argument_list)

  (parenthesized_expression)
  (generator_expression)
  (list_comprehension)
  (set_comprehension)
  (dictionary_comprehension)

  (tuple)
  (list)
  (set)
  (dictionary)

  (string)
] @fold

  ]]
  -- require("vim.treesitter.query").set_query("python", "folds", folds_query)
  require("vim.treesitter.query").set("python", "folds", folds_query)
end

if require("nvim-treesitter.parsers").has_parser "lua" then
  local folds_query = [[
(while_statement (block) @fold)
(for_statement (block) @fold)
(if_statement (block) @fold)
(function_declaration (block) @fold)
  ]]
  -- require("vim.treesitter.query").set_query("lua", "folds", folds_query)
  require("vim.treesitter.query").set("lua", "folds", folds_query)
end
