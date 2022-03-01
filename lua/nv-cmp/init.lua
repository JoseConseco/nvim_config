local cmp = require('cmp')
local compare = require('cmp.config.compare')
local cmp_buffer = require('cmp_buffer')
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

local press = function(key)
	vim.api.nvim_feedkeys(t(key, true, true, true), "n", true)
end


vim.opt.completeopt = 'menu,menuone,noselect,noinsert'
cmp.setup {
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			menu = ({
				cmp_tabnine = "[T9]",
				nvim_lsp = "[LSP]",
				ultisnips = "[USnip]",
				dictionary = "[DICT]",
				spell = "[SPELL]",
				nvim_lua = "[LUA]",
				rg = "[RG]",
				-- vsnip = "[Vsnip]",
				buffer = "[Buffer]",
				path = "[Path]",
				calc = '[Calc]',
			})
			-- print(vim.inspect(entry))
		}),
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
				press("<C-R>=UltiSnips#JumpBackwards()<CR>")
			elseif vim.fn.pumvisible() == 1 then
				press("<C-p>")
			elseif cmp.visible() then
				cmp.select_prev_item()
			else
				press("<S-tab>")
			end
		end, { "i", "s"}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
				press("<esc>:call UltiSnips#JumpForwards()<CR>")
				--[[ if vim.fn.mode() == 's' then
					press("<esc>:call UltiSnips#JumpForwards()<CR>")
				elseif vim.fn.mode() == 'i' then
				press("<C-R>=UltiSnips#JumpForwards()<CR>") ]]
				-- end
			elseif vim.fn.pumvisible() == 1 then
				press("<C-n>")
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
						return press("<C-R>=UltiSnips#ExpandSnippet()<CR>")
					else
						cmp.complete()
					end
				else -- no selected entry
					local copilot_keys = vim.fn["copilot#Accept"]()
					if copilot_keys ~= "" then
						vim.api.nvim_feedkeys(copilot_keys, "i", true)
					else
						press("<C-e>") -- close if no entry selecte
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
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	sources = cmp.config.sources({
		-- { name = "nvim_lsp_signature_help" },
		{ name = 'cmp_tabnine' },
		{ name = 'ultisnips'},
		{ name = 'spell' },
		{ name = "dictionary", keyword_length = 2, },    -- from uga-rosa/cmp-dictionary plug
		{ name = 'nvim_lsp'},
		{ name = 'buffer'}, -- first for locality sorting?
		-- { name = 'rg'},
		{ name = 'nvim_lua'},
		-- { name = 'path' },
		{ name = 'fuzzy_path'}, -- from tzacher
		{ name = 'calc' },
		-- { name = 'vsnip' },
	}),
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
			function(...)
				if vim.api.nvim_get_mode().mode:sub(1, 1) ~= 'c' then
					return cmp_buffer:compare_locality(...)
				end
			end,
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
			name = 'fuzzy_buffer', option = { }
		}
	})
})

-- be_string
-- /\vstring/search
-- /\mstring/search

vim.cmd [[
augroup SetCmpColors
autocmd!
" gray
autocmd ColorScheme * highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
autocmd ColorScheme * highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
autocmd ColorScheme * highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
autocmd ColorScheme * highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
autocmd ColorScheme * highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
autocmd ColorScheme * highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
" pink
autocmd ColorScheme * highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
autocmd ColorScheme * highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
" front
autocmd ColorScheme * highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
autocmd ColorScheme * highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
autocmd ColorScheme * highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4
augroup END
]]

-- dict plugin
require("cmp_dictionary").setup({
    dic = {
        ["markdown"] = { "/home/bartosz/american_english.dic" },
    },
    -- The following are default values, so you don't need to write them if you don't want to change them
    exact = 2,
    first_case_insensitive = false,
    async = false,
    capacity = 5,
    debug = false,
})
