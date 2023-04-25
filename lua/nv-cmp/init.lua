local cmp = require "cmp"
local compare = require "cmp.config.compare"
local lspkind = require "lspkind"

local replace_keycodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local press = function(key)
  vim.api.nvim_feedkeys(replace_keycodes(key), "m", true)
end

-- vim.opt.completeopt = "menu,menuone,noselect,noinsert" -- not needed anymore - actually needed for cmp-dap...
cmp.setup {
  sources = cmp.config.sources {
    -- { name = "nvim_lsp_signature_help" },
    { name = "copilot",     priority = 9, group_index = 1, keyword_length = 0 },
    { name = "nvim_lsp", priority = 8, group_index = 1, keyword_length = 2, max_item_count = 5 },
    { name = "cmp_tabnine", priority = 8, group_index = 1, keyword_length = 2 },
    { name = "cmp_dap", priority = 7, group_index = 1 },
    { name = "ultisnips", priority = 7, group_index = 1 },
    { name = "nvim_lua", priority = 5, group_index = 1 },
    -- { name = "buffer",      priority = 5, group_index = 1, keyword_length = 2, max_item_count = 5 }, -- actually nicer than RG
    { name = "rg", priority = 5, group_index = 1, keyword_length = 2, max_item_count = 4 }, -- first for locality sorting?
    { name = "spell", priority = 5, group_index = 1, keyword_length = 3, keyword_pattern = [[\w\+]] },
    { name = "calc", priority = 3, group_index = 1, keyword_pattern = [[\d\+\W\{-\}\d]] },
    { name = "path", priority = 1, group_index = 1 },
    -- { name = 'vsnip' },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        cmp_tabnine = "[T9]",
        copilot = "[COP]",
        cmp_dap = "[DAP]",
        nvim_lsp = "[LSP]",
        ultisnips = "[USnip]",
        spell = "[SPELL]", -- from f3fora/cmp-spell (vim spell has to be enabled)
        nvim_lua = "[LUA]",
        rg = "[RG]",
        path = "[PATH]",
        buffer = "[Buffer]",
        calc = "[Calc]",
      },
    },
  },
  -- enabled = function ()  -- for cmp dap
  --   return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
  --     or require("cmp_dap").is_dap_buffer()
  -- end,
  -- You can set mappings if you want
  window = {
    documentation = {
      border = "rounded",
      scrollbar = "║",
    },
  },
  matching = {
    disallow_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
    disallow_partial_fuzzy_matching = false,
  },

  completion = {
    border = "rounded",
    scrollbar = "║",
    keyword_length = 0,
  },

  mapping = {
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        press "<C-R>=UltiSnips#JumpBackwards()<CR>"
      elseif vim.fn.pumvisible() == 1 then
        press "<C-p>"
      elseif cmp.visible() then
        cmp.select_prev_item()
      else
        press "<S-tab>"
      end
    end, { "i", "s", "c" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
        press "<esc>:call UltiSnips#JumpForwards()<CR>"
        --[[ if vim.fn.mode() == 's' then
					press("<esc>:call UltiSnips#JumpForwards()<CR>")
				elseif vim.fn.mode() == 'i' then
				press("<C-R>=UltiSnips#JumpForwards()<CR>") ]]
        -- end
      elseif vim.fn.pumvisible() == 1 then
        press "<C-n>"
      elseif cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s", "c" }),
    ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "s", "c" }),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { -- remapped at bottom by autopairs
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-SPACE>"] = cmp.mapping(function(fallback)
      -- print(vim.inspect(vim.fn.complete_info()))
      if cmp.visible() then
        if cmp.core.view:get_selected_entry() then
          if vim.fn["UltiSnips#CanExpandSnippet"]() == 1 then
            return press "<C-R>=UltiSnips#ExpandSnippet()<CR>"
          else
            cmp.complete()
          end
        else -- no selected entry
          local copilot_keys = require("copilot.suggestion").is_visible()
          if copilot_keys ~= "" then
            require("copilot.suggestion").accept()
            -- vim.api.nvim_feedkeys(copilot_keys, "i", true)
          else
            press "<C-e>" -- close if no entry selecte
            -- cmp.complete()  -- force invoke popup
          end
        end
      else -- no popup
        -- local copilot_keys = vim.fn["copilot#Accept"]()
        local copilot_keys = require("copilot.suggestion").is_visible()
        if copilot_keys ~= "" then
          -- vim.api.nvim_feedkeys(copilot_keys, "i", true)
          require("copilot.suggestion").accept()
        else
          -- fallback()
          cmp.complete() -- force invoke popup
        end

        -- fallback()
      end
    end, { "i", "s" }),
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  sorting = {
    priority_weight = 0.8,
    comparators = {
      -- compare.score_offset, -- not good at all
      compare.scopes, -- treesitter scope
      compare.locality,
      compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      compare.offset,
      compare.recently_used,
      compare.order,
      -- compare.scopes, -- what?
      -- compare.sort_text,
      -- compare.exact,
      -- compare.kind,
      -- compare.length,
    },
  },
}

-- form "rcarriga/cmp-dap",
-- enable cmp-dap - only for dap-repl - or else cmp will throw error

require("cmp").setup.filetype("dap-repl", {
  -- nvim-cmp by defaults disables autocomplete for prompt buffers
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
  end,
  sources = {
    { name = "dap" },
  },
})

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  formatting = {
    format = function(entry, vim_item)
      -- vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
      vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, 50) -- hack to clamp cmp-cmdline-history len
      vim_item.menu = ({
        cmdline_history = "[HIST]",
        cmdline = "[CMD]",
        path = "[PATH]",
        buffer = "[BUFF]",
      })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = "cmdline", priority = 2, group_index = 1 },
    { name = "cmdline_history", priority = 1, group_index = 1, max_item_count = 3 },
    { name = "path", priority = 1, group_index = 2 }, -- from tzacher
    -- { name = "buffer",          priority = 1, group_index = 1 },
  },
})
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    -- { name = 'buffer' },
    { name = "rg" }, -- or 'rg'
    -- {
    --   name = "buffer",
    --   option = {},
    -- },
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      compare.recently_used,
      compare.offset,
      compare.score,
      compare.exact,
      compare.kind,
      compare.sort_text,
      compare.order,
    },
  },
})

vim.cmd [[
augroup SetCmpColors
autocmd!
" gray
autocmd ColorScheme * highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
" blue
autocmd ColorScheme * highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
autocmd ColorScheme * highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
" light blue
augroup END
]]
-- autocmd ColorScheme * highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
-- autocmd ColorScheme * highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE
-- autocmd ColorScheme * highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE
-- " pink
-- autocmd ColorScheme * highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
-- autocmd ColorScheme * highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
-- " front
-- autocmd ColorScheme * highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
-- autocmd ColorScheme * highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4
-- autocmd ColorScheme * highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4

-- dict plugin
-- require("cmp_dictionary").setup {
--   dic = {
--     ["markdown"] = { "/home/bartosz/american_english.dic" },
--   },
--   -- The following are default values, so you don't need to write them if you don't want to change them
--   exact = 2,
--   first_case_insensitive = false,
--   async = false,
--   capacity = 5,
--   debug = false,
-- }
