local cmp = require('cmp')
local lspkind = require("lspkind")

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end


cmp.setup {
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]..' '..vim_item.kind
			vim_item.menu = ({
				cmp_tabnine = "[T9]",
				nvim_lsp = "[LSP]",
				ultisnips = "[USnip]",
				nvim_lua = "[LUA]",
				-- vsnip = "[Vsnip]",
				buffer = "[Buffer]",
				path = "[Path]",
				calc = '[Calc]',
			})[entry.source.name]
			return vim_item
		end
	},
	documentation = {
		border = {
		      {"┌", "FloatBorder"},
		      {"─", "FloatBorder"},
		      {"┐", "FloatBorder"},
		      {"│", "FloatBorder"},
		      {"┘", "FloatBorder"},
		      {"─", "FloatBorder"},
		      {"└", "FloatBorder"},
		      {"│", "FloatBorder"},
			}
	},
	min_length = 0, -- allow for `from package import _` in Python
	-- You can set mappings if you want
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				return vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpBackwards()<CR>"))
			elseif vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-p>"), "n")
			elseif check_back_space() then
				vim.fn.feedkeys(t("<S-tab>"), "n")
			else
				fallback()
			end
		end, { "i", "s", }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				return vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpForwards()<CR>"))
			elseif vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-n>"), "n")
			elseif check_back_space() then
				vim.fn.feedkeys(t("<tab>"), "n")
			else
				fallback()
			end
		end, { "i", "s", }),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['<C-Space>'] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
					return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
				end

				vim.fn.feedkeys(t("<C-n>"), "n")
			elseif check_back_space() then
				vim.fn.feedkeys(t("<cr>"), "n")
			else
				fallback()
			end
		end, { "i", "s", }),
	},

	-- snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
	-- You should specify your *installed* sources.
	sources = {
		{ name = 'cmp_tabnine' },
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'nvim_lua' },
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'calc' },
		-- { name = 'vsnip' },
	},
}

-- windwp/nvim-autopairs -  you need setup cmp first put this after cmp.setup()
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})
