local cmp = require('cmp')
local compare = require('cmp.config.compare')
local lspkind = require("lspkind")

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end


compare.score_offset = function(entry1, entry2)
  local diff_offset_score = entry1:get_offset() * entry2.score - entry2:get_offset() * entry1.score
  if diff_offset_score < 0 then
    return true
  elseif diff_offset_score > 0 then
    return false
  end
end

vim.opt.completeopt = 'menu,menuone,noselect,noinsert'
cmp.setup {
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]..' '..vim_item.kind
			vim_item.menu = ({
				cmp_tabnine = "[T9]",
				nvim_lsp = "[LSP]",
				ultisnips = "[USnip]",
				nvim_lua = "[LUA]",
				rg = "[RG]",
				-- vsnip = "[Vsnip]",
				buffer = "[Buffer]",
				path = "[Path]",
				calc = '[Calc]',
			})[entry.source.name]
			-- print(vim.inspect(entry))
			return vim_item
		end
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	min_length = 0, -- allow for `from package import _` in Python
	-- You can set mappings if you want
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
				vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpBackwards()<CR>"))
			elseif vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-p>"), "n")
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				vim.fn.feedkeys(t("<S-tab>"), "n")
			end
		end, { "i", "s"}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				vim.fn.feedkeys(t("<esc>:call UltiSnips#JumpForwards()<CR>"))
				--[[ if vim.fn.mode() == 's' then
					vim.fn.feedkeys(t("<esc>:call UltiSnips#JumpForwards()<CR>"))
				elseif vim.fn.mode() == 'i' then
					vim.fn.feedkeys(t("<C-R>=UltiSnips#JumpForwards()<CR>")) ]]
				-- end
			elseif vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-n>"), "n")
			elseif cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s"}),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.close(),
		-- ['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ -- remapped at bottom by autopairs
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['<C-SPACE>'] = cmp.mapping(function(fallback)
			-- print(vim.inspect(vim.fn.complete_info()))
			if cmp.visible() then
				if cmp.core.view:get_selected_entry() then
					if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
						return vim.fn.feedkeys(t("<C-R>=UltiSnips#ExpandSnippet()<CR>"))
					else
						cmp.complete()
          end
				else -- no selected entry
					local copilot_keys = vim.fn["copilot#Accept"]()
					if copilot_keys ~= "" then
						vim.api.nvim_feedkeys(copilot_keys, "i", true)
					else
						vim.fn.feedkeys(t("<C-e>"), "n") -- close if no entry selected
						-- cmp.complete()  -- force invoke popup
					end
				end
			else -- no popup
				local copilot_keys = vim.fn["copilot#Accept"]()
				if copilot_keys ~= "" then
					vim.api.nvim_feedkeys(copilot_keys, "i", true)
				else
					-- fallback()
					cmp.complete()  -- force invoke popup
				end

				-- fallback()

			end
		end, { "i", "s", }),
	},


	-- snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end},
	-- You should specify your *installed* sources.
	sources = {
		{ name = 'cmp_tabnine' },
		{ name = 'ultisnips'},
		{ name = 'nvim_lsp'},
		{ name = 'rg'},
		{ name = 'buffer'},
		{ name = 'nvim_lua'},
		-- { name = 'path' },
		{ name = 'fuzzy_path'}, -- from tzacher
		{ name = 'calc' },
		-- { name = 'vsnip' },
	},
	sorting = {
		priority_weight = 1.5,
		--[[ comparators = {
				compare.offset,
				compare.exact,
				compare.score,
				compare.kind,
				compare.sort_text,
				compare.length,
				compare.order,
		} ]]
		comparators = {
			-- compare.score_offset, -- not good at all
			compare.recently_used,
			compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
			compare.offset,
			compare.order,
			-- compare.sort_text,
			-- compare.exact,
			-- compare.kind,
			-- compare.length,
		}
	}
}


-- windwp/nvim-autopairs -  you need setup cmp first put this after cmp.setup()
--[[ require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = false -- automatically select the first item
}) ]]
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))

cmp.setup.cmdline(':', {
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]..' '..vim_item.kind
			vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, 50) -- hack to clamp cmp-cmdline-history len
			vim_item.menu = ({
				cmdline_history = "[HIST]",
				cmdline = "[CMD]",
				fuzzy_path = "[PATH]",
				buffer = "[BUFF]",
			})[entry.source.name]
			return vim_item
		end
	},
  sources = cmp.config.sources( {
		{ name = 'cmdline_history' },
    { name = 'cmdline' },
		{ name = 'fuzzy_path'}, -- from tzacher
    { name = 'buffer' },
  })
})
cmp.setup.cmdline('/', {
  sources = cmp.config.sources({
		-- { name = 'buffer' },
		-- { name = 'rg'}, -- or 'rg'
		{
			name = 'fuzzy_buffer', opts = { }
		}
	})
})

-- be_string
-- /\vstring/search
-- /\mstring/search
