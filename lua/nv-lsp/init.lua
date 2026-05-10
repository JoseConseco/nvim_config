require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
})


local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

local lsp_doc_hl_au_idx = vim.api.nvim_create_augroup("lsp_document_highlight", {})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Disable semantic tokens (hlargs.nvim compatibility)
    client.server_capabilities.semanticTokensProvider = nil

    local bufnr = ev.buf
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    buf_set_keymap("n", "gd", ":lua require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "gr", ":lua require('telescope.builtin').lsp_references({initial_mode = 'normal'})<CR>", opts)
    buf_set_keymap("n", "<space>cf", [[<cmd>lua require('conform').format({lsp_fallback = true})<CR>]], opts)
    buf_set_keymap("v", "<space>cf", [[<cmd>lua require('conform').format({lsp_fallback = true, range=require('conform').Range})<CR>]], opts)

    if client.server_capabilities.hoverProvider then
      vim.api.nvim_set_hl(0, "LspReferenceRead", { reverse = true })
      vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
      vim.api.nvim_set_hl(0, "LspReferenceWrite", { reverse = true })

      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
        group = lsp_doc_hl_au_idx,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
        group = lsp_doc_hl_au_idx,
      })
    end
  end,
})

-- clangd
vim.lsp.config('clangd', {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16", -- get rid of "Multiple different client offset_encodings detected" warning
  },
})
vim.lsp.enable('clangd')

-- basedpyright
local python_root_markers = { 'requirements.txt', 'main.py', '.git' }

vim.lsp.config('basedpyright', {
  capabilities = capabilities,
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = python_root_markers,
  single_file_support = true,
  settings = {
    basedpyright = {
      analysis = {
        extraPaths = { "/home/bartosz/.local/lib/python3.11/site-packages/" },
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",     -- ["off", "basic", "strict"]
        diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
        diagnosticSeverityOverrides = {
          reportDuplicateImport = "warning",
          reportImportCycles = "warning",
          reportMissingImports = "error",
          reportMissingModuleSource = "error",
        },
      },
    },
  },
})
vim.lsp.enable('basedpyright')

-- ruff - fast Python linter and formatter
local py_format_toml = '/home/bartosz/.config/nvim/lua/nv-lsp/ruff_py_format.toml'
local py_lint_toml = '/home/bartosz/.config/nvim/lua/nv-lsp/ruff_py_lint.toml'

vim.lsp.config('ruff', {
  capabilities = capabilities,
  cmd = { "ruff", "server" },
  filetypes = { "python" },
  init_options = {
    settings = {
      format = {
        enabled = true,
        args = { '--config=' .. py_format_toml },
      },
      lint = {
        enabled = true,
        args = { '--config=' .. py_lint_toml },
      },
    },
  },
  single_file_support = true,
  root_markers = python_root_markers,
})
vim.lsp.enable('ruff')

-- lua_ls
vim.lsp.config('lua_ls', {
  cmd = { "lua-language-server", "-E", "/usr/share/lua-language-server/main.lua" },
  capabilities = capabilities,
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})
vim.lsp.enable('lua_ls')

-- vimls
vim.lsp.config('vimls', {
  cmd = { "vim-language-server", "--stdio" },
  capabilities = capabilities,
  filetypes = { "vim" },
  init_options = {
    diagnostic = { enable = true },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
      runtimepath = true,
    },
    iskeyword = "@,48-57,_,192-255,-#",
    runtimepath = "",
    suggest = {
      fromRuntimepath = true,
      fromVimruntime = true,
    },
    vimruntime = "",
  },
  root_markers = { '.git' },
})
vim.lsp.enable('vimls')

-- ltex
vim.lsp.config('ltex', {
  cmd = { "/home/bartosz/Publiczny/ltex-ls-16.0.0/bin/ltex-ls" },
  capabilities = capabilities,
  filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
  root_markers = { '.git' },
  single_file_support = true,
})
vim.lsp.enable('ltex')
