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
  indent = { enable = false }, -- broken since 0.10?
  -- playground = {
  --     enable = true,
  --     disable = {},
  --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  --     persist_queries = false -- Whether the query persists across vim sessions
  -- },
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = "gnn",
      node_incremental = "v",
      -- scope_incremental = "grc",
      node_decremental = "V",
    },
  },
  autopairs = { enable = true }, -- for windwp/nvim-autopairs plug
  matchup = {
    -- for andymass/vim-matchup
    enable = true, -- mandatory, false will disable the whole extension
    disable = { "ruby" }, -- optional, list of language that will be disabled
  },
  -- markid = { enable = true }, -- for		use 'David-Kunz/markid'
  textobjects = {
    -- uses 'nvim-treesitter/nvim-treesitter-refactor'
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
        ["]f"] = "@function.outer",
        ["]c"] = "@class.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[c"] = "@class.outer",
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


-- see /home/bartosz/.local/share/nvim/lazy/nvim-treesitter/queries/c/folds.scm
if require("nvim-treesitter.parsers").has_parser "c" and require("nvim-treesitter.parsers").has_parser "cpp" then
        local folds_query = [[
        [
           (compound_statement)
        ] @fold
        ]]
        require("vim.treesitter.query").set("c", "folds", folds_query)
        require("vim.treesitter.query").set("cpp", "folds", folds_query)
   end
