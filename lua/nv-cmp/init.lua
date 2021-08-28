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
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				cmp_tabnine = "[T9]",
				vsnip = "[Vsnip]",
			})[entry.source.name]
			return vim_item
		end
	},
	min_length = 0, -- allow for `from package import _` in Python
	-- You can set mappings if you want
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = function(fallback)
				if vim.fn['vsnip#jumpable']() == 1 then
					vim.fn.feedkeys(t('<plug>(vsnip-jump-prev)'), '')
				elseif vim.fn.pumvisible() == 1 then
					vim.fn.feedkeys(t('<C-p>'), '')
				else
					fallback()
				end
		end,
		['<Tab>'] = function(fallback)
				if vim.fn['vsnip#jumpable']() == 1 then
					vim.fn.feedkeys(t('<plug>(vsnip-jump-next)'), '')
				elseif vim.fn.pumvisible() == 1 then
					vim.fn.feedkeys(t('<C-n>'), '')
				else
					fallback()
				end
		end,
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),
		['<C-Space>'] = function(fallback)
			if vim.fn['vsnip#available']() == 1 then
				vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
			elseif vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t('<CR>'), '')
			else
				fallback()
			end
		end,
	},

	-- You should specify your *installed* sources.
	sources = {
		{ name = 'buffer' },
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'cmp_tabnine' },
		{ name = 'nvim_lua' },
		{ name = 'vsnip' },
	},
}
