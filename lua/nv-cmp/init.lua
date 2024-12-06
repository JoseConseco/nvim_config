local cmp = require "cmp"
local compare = require "cmp.config.compare"
local lspkind = require "lspkind"

local replace_keycodes = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local press = function(key)
  vim.api.nvim_feedkeys(replace_keycodes(key), "m", true)
end

local bounce_delay = 350 -- ms

local source_mapping = {
  -- cmp_tabnine = "[T9]",
  -- copilot = "[COP]",
  cmp_ai = "[OLLAMA]",
  cmp_dap = "[DAP]",
  nvim_lsp = "[LSP]",
  ultisnips = "[USnip]",
  spell = "[SPELL]", -- from f3fora/cmp-spell (vim spell has to be enabled)
  nvim_lua = "[LUA]",
  rg = "[RG]",
  path = "[PATH]",
  buffer = "[Buffer]",
  calc = "[Calc]",
}

local cmp_ultisnips_mappings = require "cmp_nvim_ultisnips.mappings"
-- not needed anymore - actually needed for cmp-dap, or else it will auto insert first entry after dot.
-- vim.opt.completeopt = "menu,menuone,noselect,noinsert"
cmp.setup {
  -- enabled = function()
  --  return vim.api.nvim_get_mode().mode == 'c'
  -- end,
  completion = {
    -- autocomplete = { cmp.TriggerEvent.InsertEnter, cmp.TriggerEvent.TextChanged },
    -- border = "rounded",
    -- scrollbar = "║",
    keyword_length = 0,
  },
  performance = {
    -- disable = true,
    debounce = bounce_delay, -- ms
    -- throttle = 400, -- does it even work?
    -- fetching_timeout = 0.1,
    max_view_limit = 14,
  },
  sources = cmp.config.sources {
    -- { name = "nvim_lsp_signature_help" },
    -- { name = "copilot", priority = 11, group_index = 1, keyword_length = 0 },
    { name = "lazydev", group_index = 0}, -- set group index to 0 to skip loading LuaLS completions - for lazydev.nvim - folke
    { name = "cmp_ai", priority = 10, group_index = 1, keyword_length = 0 },
    -- { name = "cmp_tabnine", priority = 8, group_index = 1, keyword_length = 0 },
    { name = "nvim_lsp", priority = 9, group_index = 1, keyword_length = 2, max_item_count = 6 },
    { name = "cmp_dap", priority = 9, group_index = 1 },
    { name = "ultisnips", priority = 7, group_index = 1, keyword_length = 2, max_item_count = 4},
    { name = "nvim_lua", priority = 5, group_index = 1 },
    -- { name = "buffer",      priority = 5, group_index = 1, keyword_length = 2, max_item_count = 5 }, -- actually nicer than RG
    { name = "rg", priority = 5, group_index = 1, keyword_length = 2, max_item_count = 4 }, -- first for locality sorting?
    { name = "spell", priority = 5, group_index = 1, keyword_length = 3, keyword_pattern = [[\w\+]] },
    { name = "calc", priority = 3, group_index = 1, keyword_pattern = [[\d\+\W\{-\}\d]] },
    { name = "path", priority = 1, group_index = 1, keyword_length = 3 },
    -- { name = 'vsnip' },
  },
  formatting = {
    format = function(entry, vim_item)
      -- if you have lspkind installed, you can use it like
      -- in the following line:
      vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
      vim_item.menu = source_mapping[entry.source.name]
      -- if entry.source.name == "cmp_tabnine" then
      --   local detail = (entry.completion_item.labelDetails or {}).detail
      --   vim_item.kind = ""
      --   if detail and detail:find ".*%%.*" then
      --     vim_item.kind = vim_item.kind .. " " .. detail
      --   end
      --
      --   if (entry.completion_item.data or {}).multiline then
      --     vim_item.kind = vim_item.kind .. " " .. "[ML]"
      --   end
      -- end
      local maxwidth = 80
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
      return vim_item
    end,
  },
  snippet = {
    expand = function(args)
      vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  enabled = function ()  -- for cmp dap
    local current_win_id = vim.fn.win_getid() -- if windows if floating then ignore
    if vim.api.nvim_win_get_config(current_win_id).zindex then
      return
    end
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
      or require("cmp_dap").is_dap_buffer()
  end,
  -- You can set mappings if you want
  window = {
    documentation = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
  },
  matching = {
    disallow_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = false,
    disallow_partial_fuzzy_matching = false,
  },

  mapping = {
    ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s", "c" }),
    ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s", "c" }),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-x>"] = cmp.mapping(
      cmp.mapping.complete {
        config = {
          reason = cmp.ContextReason.Auto, -- or Manual
          sources = cmp.config.sources {
            { name = "copilot" },
            { name = "cmp_ai" },
          },
        },
      },
      { "i" }
    ),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
        cmp_ultisnips_mappings.jump_backwards(fallback)
        -- press "<C-R>=UltiSnips#JumpBackwards()<CR>"
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
        cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        -- press "<esc>:call UltiSnips#JumpForwards()<CR>"
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
    ["<Esc>"] = cmp.mapping.abort(),
    ["<C-e>"] = cmp.mapping(cmp.mapping.close(), { "i", "s", "c" }),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { -- remapped at bottom by autopairs
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    -- ['<C-Space>'] = cmp.mapping.complete(),
    ["<C-]>"] = cmp.mapping.complete(), -- manual trigger
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
  sorting = {
    priority_weight = 1.0,
    comparators = {
      -- compare.score_offset, -- not good at all
      compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      compare.scopes, -- treesitter scope
      compare.locality,
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

cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
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
    { name = "cmdline_history", priority = 2, group_index = 1, max_item_count = 3 },
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


-- use CodeQwen1.5 since Deepseek broke (old tokenizer warning somthing)...
local cmp_ai = require "cmp_ai.config"
cmp_ai:setup {
  max_lines = 30,
  provider = "DocileLlamaCpp", -- my local LlamaCpp forvading server (will auto start different models)
  provider_options = {
    -- prompt="<｜fim▁begin｜>"..lines_before.."<｜fim▁hole｜>"..lines_after.."<｜fim▁end｜>"
    options = {
      temperature = 0.1,
      n_predict = 35,  -- number of generated predictions
      min_p = 0.1, -- default 0.05,  Cut off predictions with probability below  Max_prob * min_p
      -- repeat_last_n = 64, -- default 64
      -- repeat_penalty = 1.100, -- default 1.1


      -- new args for my forwarding my python server  branch.. ---------------
      -- model = "CodeQwen1.5-7B-Q4_K_S.gguf", -- still best?
      -- model = "Qwen2.5-Coder-7B-Instruct-Q5_K_S", -- last's best with FIM and instruct at same time
      model = "Qwen2.5.1-Coder-7B-Instruct-Q5_K_M", -- is at as good as 2.5?
      -- cache_prompt= true, -- is necessary for llama.cpp to use the draft model -not..
      md = "Qwen2.5.1-Coder-1.5B-Instruct-Q6_K.gguf", --
      ngl = 50,
    },
    prompt = function(lines_before, lines_after)
      return '<|fim_prefix|>' .. lines_before .. '<|fim_suffix|>' .. lines_after .. '<|fim_middle|>' -- CodeQwen1

      -- codegeex4-all-9b-Q4_K_M - not so good
      -- local upper_first_ft = vim.bo.filetype:gsub('^%l', string.upper)
      -- local file_name = vim.fn.expand "%:t"
      -- return '<|user|>\n###PATH:'..file_name..'\n###LANGUAGE:'.. upper_first_ft ..'\n###MODE:LINE\n<|code_suffix|>' .. lines_after .. '<|code_prefix|>' .. lines_before .. '<|code_middle|><|assistant|>\n' -- codegeex4-all-9b-Q4_K_M

      -- return "<s><｜fim▁begin｜>" .. lines_before .. "<｜fim▁hole｜>" .. lines_after .. "<｜fim▁end｜>" -- for deepseek coder
      -- return "<fim_prefix>" .. lines_before .. "<fim_suffix>" .. lines_after .. "<fim_middle>" -- for Refact 1.5 coder -- stopped workign after llama update..
    end,
  },
  debounce_delay = 600, -- ms
  notify = true,
  notify_callback = function(msg)
    print(msg)
    -- vim.notify(msg)
  end,
  run_on_every_keystroke = false,
  ignored_file_types = {
    -- default is not to ignore
    -- uncomment to ignore in lua:
    -- lua = true
    -- markdown = true,
  },
}

-- deepseek ver - docile llame
-- cmp_ai:setup {
--   max_lines = 30,
--   provider = "DocileLlamaCpp", -- my local LlamaCpp forvading server (will auto start different models)
--   provider_options = {
--     -- prompt="<｜fim▁begin｜>"..lines_before.."<｜fim▁hole｜>"..lines_after.."<｜fim▁end｜>"
--     options = {
--       -- temperature = 0.2,
--       n_predict = 35,  -- number of generated predictions
--       min_p = 0.2, -- default 0.05,  Cut off predictions with probability below  Max_prob * min_p
--       -- repeat_last_n = 64, -- default 64
--       -- repeat_penalty = 1.100, -- default 1.1
--
--
--       -- new args for my forwarding my python server  branch.. ---------------
--       model = "deepseek-coder-6.7b-base.Q4_K_M.gguf",
--       ngl = 50,
--     },
--     prompt = function(lines_before, lines_after)
--       return "<s><｜fim▁begin｜>" .. lines_before .. "<｜fim▁hole｜>" .. lines_after .. "<｜fim▁end｜>" -- for deepseek coder
--       -- return "<fim_prefix>" .. lines_before .. "<fim_suffix>" .. lines_after .. "<fim_middle>" -- for Refact 1.5 coder -- stopped workign after llama update..
--     end,
--   },
--   debounce_delay = 600, -- ms
--   notify = true,
--   notify_callback = function(msg)
--     print(msg)
--     -- vim.notify(msg)
--   end,
--   run_on_every_keystroke = false,
--   ignored_file_types = {
--     -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true
--     -- markdown = true,
--   },
-- }

-- cmp_ai:setup {
--   max_lines = 30,
--   provider = "LlamaCpp",
--   provider_options = {
--     -- prompt="<｜fim▁begin｜>"..lines_before.."<｜fim▁hole｜>"..lines_after.."<｜fim▁end｜>"
--     options = {
--       -- temperature = 0.2,
--       n_predict = 20,  -- number of generated predictions
--       min_p = 0.2, -- default 0.05,  Cut off predictions with probability below  Max_prob * min_p
--       -- repeat_last_n = 64, -- default 64
--       -- repeat_penalty = 1.100, -- default 1.1
--
--
--
--       -- new args for my forwading server  branch.. ---------------
--       model = "deepseek-coder-6.7b-base.Q4_K_M.gguf",
--       ngl = 50,
--     },
--     prompt = function(lines_before, lines_after)
--       return "<s><｜fim▁begin｜>" .. lines_before .. "<｜fim▁hole｜>" .. lines_after .. "<｜fim▁end｜>" -- for deepseek coder
--       -- return "<fim_prefix>" .. lines_before .. "<fim_suffix>" .. lines_after .. "<fim_middle>" -- for Refact 1.5 coder -- stopped workign after llama update..
--     end,
--   },
--   debounce_delay = 600, -- ms
--   notify = true,
--   notify_callback = function(msg)
--     print(msg)
--     -- vim.notify(msg)
--   end,
--   run_on_every_keystroke = false,
--   ignored_file_types = {
--     -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true
--   },
-- }

-- cmp_ai:setup {
--   max_lines = 30,
--   provider = "Ollama",
--   provider_options = {
--     model = 'deepseek-coder:6.7b-base-q4_K_M', -- way stronger version.. but not working..--need custom promps.
--     prompt = function(lines_before, lines_after)
--       return "<s><｜fim▁begin｜>" .. lines_before .. "<｜fim▁hole｜>" .. lines_after .. "<｜fim▁end｜>" -- for deepseek coder
--       -- return "<fim_prefix>" .. lines_before .. "<fim_suffix>" .. lines_after .. "<fim_middle>" -- for Refact 1.5 coder -- stopped workign after llama update..
--     end,
--     options = {
--       temperature = 0.2,
--       -- num_predict = 20,  -- number of generated predictions
--     },
--   },
--   debounce_delay = 600, -- ms
--   notify = true,
--   notify_callback = function(msg)
--     vim.notify(msg)
--   end,
--   run_on_every_keystroke = false,
--   ignored_file_types = {
--     -- default is not to ignore
--     -- uncomment to ignore in lua:
--     -- lua = true
--   },
-- }


-- this will show cmp popup after bounce_delay of inactivity when typing. Works even on empty line, or after space...
local cmp_complete_force = function()
  if vim.fn.mode() == 'i' then -- and not cmp.visible() and
    local current_win_id = vim.fn.win_getid() -- if windows if floating then ignore
    if vim.api.nvim_win_get_config(current_win_id).zindex then
      return
    end
    -- Auto takes keyword_length into account, (wont ignore existing letters - unlike manual) but wont show anything if no letter in line...
    -- Manual will show popup even if no letter, but then ignores these latters it seems...
    -- check if current line has any letters : if not use Manual
    local current_line = vim.api.nvim_get_current_line()
    local has_letters = string.find(current_line, "%a") -- "%a" matches any alphabet character (equivalent to [a-zA-Z])
    -- make sure current buffer is not input box, command, or terminal
    -- cmp.complete({ reason = cmp.ContextReason.Manual }) -- without reason, it will ignore letters before cursor...
    cmp.complete({ reason = cmp.ContextReason.Manual }) --  ok after all?
    -- if has_letters then
    --   cmp.complete({ reason = cmp.ContextReason.Auto }) -- takes letters into account, but wont show popup if no letters in line
    -- else
    --   cmp.complete({ reason = cmp.ContextReason.Manual }) -- without reason, it will ignore letters before cursor...
    -- end
    -- cmp.complete()  -- gives 'old' suggestion (like it does not see characters types after first bounce... even thought using bounce_trailing)
  end
end

local cmp_complete_bounce, timer = require'throttle-debounce'.debounce_trailing(cmp_complete_force, bounce_delay, false) -- first = false (use last arg)

local au_cmp_hold_show = vim.api.nvim_create_augroup("CmpShowOnHold", { clear = true })
vim.api.nvim_create_autocmd({"TextChangedI","InsertEnter","TextChangedP"},{  -- bounce as much as possible
  pattern = {"*.py","*.lua"},
  callback = function()
    cmp_complete_bounce()
  end,
  group = au_cmp_hold_show
})

-- same for insert leave - except it will timer.close()
vim.api.nvim_create_autocmd({"InsertLeave"},{
  pattern = {"*.py","*.lua"},
  callback = function()
    timer:stop() -- do not fire timer callback on insert
  end,
 group = au_cmp_hold_show
})

