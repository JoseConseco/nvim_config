require("null-ls").setup {
  -- debug = true,
  sources = {
    require("null-ls").builtins.formatting.prettier.with {
      filetypes = { "html", "css", "javascript", "javascriptreact", "markdown", "json", "yaml" },
    }, -- support range format
    require("null-ls").builtins.formatting.stylua.with {
      extra_args = { "--config-path", "/home/bartosz/.config/nvim/lua/.stylua.toml" },
    }, -- support range format
    -- require("null-ls").builtins.formatting.yapf.with({
    -- 		extra_args = { "--style","{based_on_style: pep8, column_limit: 129}" }, -- To add more arguments to a source's defaults
    -- }), -- support range format
    require("null-ls").builtins.formatting.autopep8.with {
      -- filetypes = { "html", "json", "yaml", "markdown" },
      -- args = {},
      extra_args = { "--max-line-length=230", "--ignore=E226,E24,W50,W690" }, -- To add more arguments to a source's defaults
    }, -- support range format
    -- require("null-ls").builtins.completion.spell,
    require("null-ls").builtins.diagnostics.misspell.with{
			filetypes = { "html", "txt", "json", "markdown", "python"}
		},
		require("null-ls").builtins.diagnostics.pylint.with {
			extra_args = { "--disable=W,C,R", "--jobs=4" },
		},
  },
  -- on_attach =  function(client, bufnr)
  --   local opts =   { noremap = true, silent = true }
  --
  --   local function   buf_set_keymap(...)
  --     vim.api.nvim_buf_set_keymap(bufnr, ...)
  --   end
  --   -- if client.resolved_capabilities.document_formatting then
  --   buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  --   -- elseif client.resolved_capabilities.document_range_formatting then
  --   buf_set_keymap("v", "<space>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  --   -- end
  -- end,
}
