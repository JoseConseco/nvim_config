-- require("neodev").setup {
--   -- add any options here, or leave empty to use the default settings
-- }
local nvim_lsp = require "lspconfig"

local opts = { noremap = true, silent = true }
-- vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
-- vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local lsp_doc_hl_au_idx = vim.api.nvim_create_augroup("lsp_document_highlight", {})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  -- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap("n", "gd", ":lua require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})<CR>", opts) --zv - open fold at line
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>ll', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("n", "gr", ":lua require('telescope.builtin').lsp_references({initial_mode = 'normal'})<CR>", opts)

  -- Set some keybinds conditional on server capabilities - range does not work...
  -- if client.server_capabilities.document_formatting then
  -- buf_set_keymap("n", "<space>cf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
  -- elseif client.server_capabilities.document_range_formatting then
  -- buf_set_keymap("v", "<space>cf", "<ESC><cmd>lua vim.lsp.formatexpr()<CR>", opts)
  -- end

  -- from 'stevearc/conform.nvim'
  buf_set_keymap("n", "<space>cf", [[<cmd>lua require('conform').format({lsp_fallback = true})<CR>]], opts) -- from 'stevearc/conform.nvim'
  buf_set_keymap("v", "<space>cf", [[<cmd>lua require('conform').format({lsp_fallback = true, range=require('conform').Range})<CR>]], opts) -- from 'stevearc/conform.nvim'


  -- adding borders
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  --   border = "single",
  -- })
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  --   border = "single",
  -- })
  -- Set autocommands conditional on server_capabilities
  -- vim.pretty_print(client.server_capabilities)

  if client.server_capabilities.hoverProvider then -- in 8.0 - server_capabilities
    vim.api.nvim_set_hl(0, "LspReferenceRead", { reverse = true })
    vim.api.nvim_set_hl(0, "LspReferenceText", { reverse = true })
    vim.api.nvim_set_hl(0, "LspReferenceWrite", { reverse = true })

    -- local hl_manager = require("hl_manager") -- wont properly set on vim init....
    --
    -- hl_manager.highlight_from_src('LspReferenceRead', 'Search',{})
    -- hl_manager.highlight_from_src('LspReferenceText', 'Search',{})
    -- hl_manager.highlight_from_src('LspReferenceWrite', 'Search',{})

    vim.api.nvim_create_autocmd("CursorHold", {
      -- pattern = "*",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
      group = lsp_doc_hl_au_idx,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      -- pattern = "*",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
      group = lsp_doc_hl_au_idx,
    })
  end

  -- require'aerial'.on_attach(client) -- aerial plug - outliner - now uses treesitter
  local cfg = {
    floating_window = false,
    hint_enable = true, -- virtual hint enable
    hint_prefix = "🞉 ",
    doc_len = 0,
    floating_window_above_first = true,
    auto_close_after = 4,
    handler_opts = { border = "single" }, -- double, single, shadow, none
  }
  -- require("lsp_signature").on_attach(cfg) -- from ray-x/lsp_signature.nvim
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- not sure why but hlargs.nvim is not working. disabling semantic tokens helps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
-- local servers = { "pyright", "sumneko_lua"}
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--		capabilities = capabilities;
--		on_attach = on_attach;
--       -- init_options = {
--		--     onlyAnalyzeProjectsWithOpenFiles = true,
--		--     suggestFromUnimportedLibraries = false,
--		--     closingLabels = true,
--		-- };
--   }
-- end
-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
--
local util = require "lspconfig/util"

nvim_lsp.clangd.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16", -- get rid of "Multiple different client offset_encodings detected" warning
  },
}

-- nvim_lsp.pyright.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   cmd = { "pyright-langserver", "--stdio" },
--   filetypes = { "python" },
--   root_dir = function(filename)
--     local root_files = {
--       -- 'setup.py',
--       -- 'pyproject.toml',
--       -- 'setup.cfg',
--       'requirements.txt',
--       "main.py", --mine
--       ".git",
--     }
--     return util.root_pattern(unpack(root_files))(filename) or util.find_git_ancestor(filename) or
--         nil -- forces to run in signle file mode
--     -- util.path.dirname(filename) -- this will point to root addons == very slow
--   end,
--   settings = {
--     pyright = {
--       -- Using Ruff's import organizer
--       disableOrganizeImports = true,
--     },
--     python = {
--       analysis = {
--         extraPaths = { "/home/bartosz/.local/lib/python3.11/site-packages/" },
--         autoSearchPaths = true,
--         useLibraryCodeForTypes = true,
--         typeCheckingMode = "off",     --  ["off", "basic", "strict"]:
--         diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
--         diagnosticSeverityOverrides = {
--           -- "error," "warning," "information," "true," "false," or "none"
--           reportDuplicateImport = "warning",
--           reportImportCycles = "warning",
--           reportMissingImports = "error",
--           reportMissingModuleSource = "error",
--         },
--       },
--     },
--   },
-- }

nvim_lsp.basedpyright.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {"basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = function(filename)
    local root_files = {
      -- 'setup.py',
      -- 'pyproject.toml',
      -- 'setup.cfg',
      'requirements.txt',
      "main.py", --mine
      ".git",
    }
    return util.root_pattern(unpack(root_files))(filename) or util.find_git_ancestor(filename) or
        nil -- forces to run in signle file mode
    -- util.path.dirname(filename) -- this will point to root addons == very slow
  end,
  single_file_support = true,
  settings = {
    -- pyright = {
    --   -- Using Ruff's import organizer
    --   disableOrganizeImports = true,
    -- },
    basedpyright = {
      analysis = {
        extraPaths = { "/home/bartosz/.local/lib/python3.11/site-packages/" },
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = "off",     --  ["off", "basic", "strict"]:
        diagnosticMode = "workspace", -- ["openFilesOnly", "workspace"]
        diagnosticSeverityOverrides = {
          -- "error," "warning," "information," "true," "false," or "none"
          reportDuplicateImport = "warning",
          reportImportCycles = "warning",
          reportMissingImports = "error",
          reportMissingModuleSource = "error",
        },
      },
    },
  },
}

-- A Language Server Protocol implementation for Ruff, an extremely fast Python linter and code formatter, written in Rust.
-- get abs file path to ./py_format.toml in current dir
local py_format_toml = '/home/bartosz/.config/nvim/lua/nv-lsp/ruff_py_format.toml'
local py_lint_toml = '/home/bartosz/.config/nvim/lua/nv-lsp/ruff_py_lint.toml'
require'lspconfig'.ruff_lsp.setup{ -- rust fast, but: no hover highlight, no go definition etc
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {"ruff-lsp"},
  filetypes = { "python" },
  init_options = {
    -- Any extra CLI arguments for `ruff` go here.
    -- args = {'format --ignore=E501 --line-length=230 --max-line-length=230',},
    settings = { -- https://github.com/astral-sh/ruff-lsp?tab=readme-ov-file#settings
      format= {
        enabled = true,
        args = {'--config='..py_format_toml},
      },
      lint = {
        enabled = true,
        args = {'--config='..py_lint_toml},
      },
    }
  },
  single_file_support = true,
  root_dir = function(filename)
    local root_files = {
      -- 'setup.py',
      -- 'pyproject.toml',
      -- 'setup.cfg',
      'requirements.txt',
      "main.py", --mine
      ".git",
    }
    return util.root_pattern(unpack(root_files))(filename) or util.find_git_ancestor(filename) or nil -- forces to run in signle file mode
    -- util.path.dirname(filename) -- this will point to root addons == very slow
  end,
}


-- flake is great for showing eg. from where thing was imported... short messages
-- F405 - shows from where thing was imported
-- require('lspconfig').diagnosticls.setup {
--   filetypes = { "python" },
--   init_options = {
--     filetypes = {
--       python = {"flake8"},
--     },
--     linters = {
--       flake8 = {
--         debounce = 100,
--         sourceName = "flake8",
--         command = "flake8",
--         args = {
--           "--extend-ignore=E",
--           "--format",
--           "%(row)d:%(col)d:%(code)s:%(code)s: %(text)s",
--           "%file",
--         },
--         formatPattern = {
--           "^(\\d+):(\\d+):(\\w+):(\\w).+: (.*)$",
--           {
--               line = 1,
--               column = 2,
--               message = {"[", 3, "] ", 5},
--               security = 4
--           }
--         },
--         securities = {
--           E = "error",
--           W = "warning",
--           F = "info",
--           B = "hint",
--         },
--       },
--     },
--   }
-- }

--uses jedi, flake and others
-- nvim_lsp.pyls.setup{
--	capabilities = capabilities;
--	on_attach = on_attach;
--   settings = {
--     pyls = {
--       plugins = {
--         -- flake8 = {enabled = true},
--         pyflakes = {enabled = true},
--         pycodestyle = {enabled = false},     -- linter for style checking
--         pydocstyle = {enabled = false},
--         YAPF = {enabled = true},         --code foramtting preffered over autopep8
--         -- ['pyls-black'] = {enabled = true},         --code foramtting preffered over autopep8
--       }
--     }
--   }
-- }
-- nvim_lsp.jedi_language_server.setup{
-- 	capabilities = capabilities;
-- 	on_attach = on_attach;
-- 	cmd = { "jedi-language-server"};
-- 	filetypes = { "python" };
-- 	root_dir = function(filename)
-- 		local root_files = {
-- 			-- 'setup.py',
-- 			-- 'pyproject.toml',
-- 			-- 'setup.cfg',
-- 			-- 'requirements.txt',
-- 			'.git',
-- 		}
-- 		return util.root_pattern(unpack(root_files))(filename) or
-- 			util.find_git_ancestor(filename) or
-- 			nil -- forces to run in signle file mode
-- 			-- util.path.dirname(filename) -- this will point to root addons == very slow
-- 	end;
--   initializationOptions = {
--     diagnostics = {
--       enable = true,
--     },
--     -- jediSettings = {
--     --   autoImportModules = {'numpy', 'pandas'},
--     -- },
--   },
-- }

nvim_lsp.lua_ls.setup {
  cmd = { "lua-language-server", "-E", "/usr/share/lua-language-server/main.lua" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        -- library = {
        -- 	[vim.fn.expand('$VIMRUNTIME/lua')] = true,
        -- 	[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        -- },
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

require("lspconfig").vimls.setup {
  cmd = { "vim-language-server", "--stdio" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "vim" },
  init_options = {
    diagnostic = {
      enable = true,
    },
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
  root_dir = function(fname)
    return util.find_git_ancestor(fname) or vim.fn.getcwd()
  end,
}

require("lspconfig").ltex.setup {
  -- cmd = { "ltex-ls" },
  cmd = { "/home/bartosz/Publiczny/ltex-ls-16.0.0/bin/ltex-ls" },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex" },
  root_dir = function(fname)
    return util.find_git_ancestor(fname) or vim.fn.getcwd()
  end,
  single_file_support = true,
}
