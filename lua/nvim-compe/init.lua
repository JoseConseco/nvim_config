-- vim.cmd [[packadd nvim-lspconfig]]
-- vim.cmd [[packadd nvim-compe]]

-- vim.o.completeopt = "menuone"
vim.o.completeopt="menuone,noinsert,noselect"
require "compe".setup {
    enabled = true,
    autocomplete = true,  --Open the popup menu automatically
    debug = false,
    min_length = 0,  --Minimal characters length to trigger completion.
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 300,    --Delay for LSP's isIncomplete.
    max_abbr_width = 300,
    max_kind_width = 400,
    max_menu_width = 400,
		documentation = {
			border = "rounded",
			max_width = 120,
			min_width = 60,
			max_height = math.floor(vim.o.lines * 0.3),
			min_height = 1,
		},
    source = {
				path = {kind = " "},
        buffer = {kind = " "},
        calc = {kind = " "},
        vsnip = {kind = " ", priority=3000},
        tabnine = {kind = " ", priority=2000, max_reslts=4},
        nvim_lsp = {kind = " ", priority=1000},
        nvim_lua = {kind = " "},
        spell = {kind = " "},
        tags = false,
				omni = false,
        -- snippets_nvim = true,
        -- treesitter = true
    }
}

-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#confirm('<CR>')", {expr = true})
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- above for vsnip


-- vim.api.nvim_set_keymap("i", "<CR>", "v:compe#complete()", {expr = true})
--  vim.cmd([[
-- inoremap <silent><expr> <CR> compe#complete('<CR>')
-- snoremap <silent><expr> <CR> compe#complete('<CR>')
-- inoremap <silent><expr> <C-e>     compe#close('<C-e>')
-- inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
-- inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
-- ]])

-- vim.api.nvim_set_keymap("i", "<CR>", "v:compe#complete()", {expr = true})
-- snoremap <silent><expr> <CR> compe#complete('<CR>')
--  vim.cmd([[
-- inoremap <silent><expr> <C-Space> compe#confirm('<CR>')
-- inoremap <silent><expr> <C-e>     compe#close('<C-e>')
-- ]])

-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- 
-- ﬘
-- 
-- 
-- 
-- m
-- 
-- 
-- 
-- 
local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
		if vim.fn.call("vsnip#jumpable", {1}) == 1 then
				return t "<Plug>(vsnip-jump-next)"
    elseif vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end
_G.s_tab_complete = function()
		if vim.fn.call("vsnip#jumpable", {-1}) == 1 then
				return t "<Plug>(vsnip-jump-prev)"
    elseif vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<S-Tab>"
    end
end


local npairs = require('nvim-autopairs')
-- skip it, if you use another global object
-- _G.MUtils= {}
vim.g.completion_confirm_key = ""
_G.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<cr>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true})
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#confirm('<CR>')", {expr = true})
vim.api.nvim_set_keymap("i", "<CR>", "v:lua.completion_confirm()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "v:lua.completion_confirm()", {expr = true})
vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
