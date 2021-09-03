local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap=true, silent=true }
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	-- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gd', ":lua require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})<CR>zv", opts) --zv - open fold at line
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	-- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	-- buf_set_keymap('n', '<space>la', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>lr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
	-- buf_set_keymap('n', '<space>ll', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	-- buf_set_keymap('n', '<space>ld', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	-- buf_set_keymap('n', '<space>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	-- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	buf_set_keymap('n', 'gr', ":lua require('telescope.builtin').lsp_references({initial_mode = 'normal'})<CR>", opts)
	-- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
	-- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
	-- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
	-- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.resolved_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>F", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end

	-- adding borders
	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(
			vim.lsp.handlers.hover,
			{
				border = "single"
			}
		)
	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(
			vim.lsp.handlers.signature_help,
			{
				border = "single"
			}
		)
	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec([[
		hi LspReferenceRead cterm=bold ctermbg=red guibg=#305070
		hi LspReferenceText cterm=bold ctermbg=red guibg=#305070
		hi LspReferenceWrite cterm=bold ctermbg=red guibg=#305070
		augroup lsp_document_highlight
		autocmd! * <buffer>
		autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
		autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
			]], false)
	end
	require'aerial'.on_attach(client) -- aerial plug - outliner
	cfg={floating_window=false}
	require('lsp_signature').on_attach(cfg) -- from ray-x/lsp_signature.nvim
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true;
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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
local util = require 'lspconfig/util'
local root_files = {
	'setup.py',
	'pyproject.toml',
	'setup.cfg',
	'requirements.txt',
	'.git',
}

nvim_lsp.pyright.setup{
	capabilities = capabilities;
	on_attach = on_attach;
	cmd = { "pyright-langserver", "--stdio" };
	filetypes = { "python" };
	root_dir = function(filename)
		return util.root_pattern(unpack(root_files))(filename) or
			util.path.dirname(filename)
	end;
	settings = {
		pyright = {
			disableOrganizeImports = false,
		},
		python = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				typeCheckingMode = 'off',  --  ["off", "basic", "strict"]:
				diagnosticMode = 'workspace', -- ["openFilesOnly", "workspace"]
				diagnosticSeverityOverrides = {  -- "error," "warning," "information," "true," "false," or "none"
					reportDuplicateImport = 'warning',
					reportImportCycles = 'warning',
					reportMissingImports = 'error',
					reportMissingModuleSource = 'error',
				}
			}
		}
	};
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
--	capabilities = capabilities;
--	on_attach = on_attach;
--   init_options = {
--     diagnostics = {
--       enable = true,
--     },
--     completion = {
--       disableSnippets = true,
--     },
--     jediSettings = {
--       autoImportModules = {'numpy', 'pandas'},
--     },
--   },
-- }


nvim_lsp.sumneko_lua.setup {
	cmd = {'lua-language-server', "-E", '/usr/share/lua-language-server/main.lua'};
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
				-- Setup your lua path
				path = vim.split(package.path, ';'),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

require'lspconfig'.vimls.setup{
	cmd = { "vim-language-server", "--stdio" };
	filetypes = {"vim"},
	init_options = {
		diagnostic = {
			enable = true
		},
		indexes = {
			count = 3,
			gap = 100,
			projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
			runtimepath = true
		},
		iskeyword = "@,48-57,_,192-255,-#",
		runtimepath = "",
		suggest = {
			fromRuntimepath = true,
			fromVimruntime = true
		},
		vimruntime = "",
	},
	root_dir = function(fname)
		return util.find_git_ancestor(fname) or vim.fn.getcwd()
	end,
}
