-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/bartosz/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["accelerated-jk.nvim"] = {
    config = { "\27LJ\2\n·\2\0\0\6\0\16\0\0296\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\b\0'\2\t\0B\0\2\0029\0\n\0005\2\v\0005\3\f\0=\3\r\0024\3\3\0005\4\14\0>\4\1\3=\3\15\2B\0\2\1K\0\1\0\23deceleration_table\1\3\0\0\3¶\4\3èN\23acceleration_table\1\3\0\0\3\5\3\29\1\0\3\23acceleration_limit\3ñ\1\24enable_deceleration\1\tmode\16time_driven\nsetup\19accelerated-jk\frequire\30<Plug>(accelerated_jk_gk)\6k\30<Plug>(accelerated_jk_gj)\6j\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/accelerated-jk.nvim",
    url = "https://github.com/rainbowhxch/accelerated-jk.nvim"
  },
  ["adwaita.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/adwaita.nvim",
    url = "https://github.com/Mofiqul/adwaita.nvim"
  },
  ["aerial.nvim"] = {
    config = { "\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14nv-aerial\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/aerial.nvim",
    url = "https://github.com/stevearc/aerial.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-cmdline-history"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-cmdline-history",
    url = "https://github.com/dmitmel/cmp-cmdline-history"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-tabnine"] = {
    config = { "\27LJ\2\no\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0005\3\3\0B\0\3\1K\0\1\0\1\0\3\14max_lines\3d\tsort\2\20max_num_results\3\3\nsetup\23cmp_tabnine.config\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  ["codi.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/codi.vim",
    url = "https://github.com/metakirby5/codi.vim"
  },
  ["copilot.vim"] = {
    config = { "\27LJ\2\nÄ\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\5\25copilot_tab_fallback\26copilot_assume_mapped\23copilot_no_tab_map\6g\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["ctrlsf.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/ctrlsf.vim",
    url = "https://github.com/dyng/ctrlsf.vim"
  },
  ["dial.nvim"] = {
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-dial\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/dial.nvim",
    url = "https://github.com/monaqa/dial.nvim"
  },
  ["diffview.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["dirbuf.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/dirbuf.nvim",
    url = "https://github.com/elihunter173/dirbuf.nvim"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/far.vim",
    url = "https://github.com/brooth/far.vim"
  },
  ["focus.nvim"] = {
    config = { "\27LJ\2\nB\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\2\nsetup\nfocus\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/focus.nvim",
    url = "https://github.com/beauwilliams/focus.nvim"
  },
  ["foldsigns.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/foldsigns.nvim",
    url = "https://github.com/lewis6991/foldsigns.nvim"
  },
  footprints = {
    config = { "\27LJ\2\n∏\1\0\0\2\0\b\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0006\0\0\0009\0\1\0)\1\27\0=\1\a\0K\0\1\0\27footprintsHistoryDepth\vlinear\29footprintsEasingFunction\28footprintsOnCurrentLine\f#00c0f0\20footprintsColor\6g\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/footprints",
    url = "https://github.com/axlebedev/footprints"
  },
  ["github-nvim-theme"] = {
    config = { "\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/github-nvim-theme",
    url = "https://github.com/projekt0n/github-nvim-theme"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16nv-gitsigns\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hlargs.nvim"] = {
    config = { "\27LJ\2\nè\3\0\0\a\0\26\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\1\5\0015\3\b\0009\4\6\0009\4\a\4=\4\t\0035\4\15\0005\5\v\0005\6\n\0=\6\f\0055\6\r\0=\6\14\5=\5\16\0045\5\18\0005\6\17\0=\6\f\0055\6\19\0=\6\14\5=\5\20\4=\4\21\3B\1\2\0016\1\0\0'\3\22\0B\1\2\0029\2\23\1'\4\24\0'\5\25\0B\2\3\1K\0\1\0\16TSParameter\vHlargs\19highlight_link\15hl_manager\22excluded_argnames\vusages\1\2\0\0\tself\1\0\0\1\3\0\0\tself\bcls\17declarations\1\0\0\blua\1\2\0\0\tself\vpython\1\0\0\1\3\0\0\tself\bcls\ncolor\1\0\1\27paint_arg_declarations\1\vbright\tcyan\nsetup\vhlargs\rnightfox\tload\21nightfox.palette\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nº\n\0\0\6\0\30\0è\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\v\0'\4\18\0005\5\19\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\14\0'\4\20\0005\5\21\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\22\0'\4\23\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\24\0'\4\25\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\26\0'\4\27\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\28\0'\4\29\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\22\0'\4\23\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\24\0'\4\25\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\26\0'\4\27\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\28\0'\4\29\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\22\0'\4\23\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\24\0'\4\25\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\26\0'\4\27\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\28\0'\4\29\0004\5\0\0B\0\5\1K\0\1\0Ç\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>\6TÅ\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>\6tô\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>\6Fò\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>\6f\1\0\1\fnoremap\2\21<cmd>HopWord<cr>\1\0\1\fnoremap\2\26<cmd>HopLineStart<cr>\6v\1\0\1\fnoremap\2\17:HopWord<cr>\agw\1\0\1\fnoremap\2\22:HopLineStart<cr>\agl\6n\1\0\1\fnoremap\2\18:HopChar1<cr>\6h\6o\20nvim_set_keymap\bapi\bvim\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\nØ\2\0\0\6\0\r\0\0206\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0'\4\4\0005\5\5\0B\1\4\0016\1\6\0009\1\a\1'\3\b\0B\1\2\0019\1\t\0'\3\n\0'\4\v\0B\1\3\0016\1\0\0'\3\f\0B\1\2\1K\0\1\0\18nv-indentline\fComment\31IndentBlanklineContextChar\19highlight_link<highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine\bcmd\bvim\1\0\2\vaction\rcontrast\vfactor\3˙ˇˇˇ\15\vNormal\15IndentEven\23highlight_from_src\15hl_manager\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["inspired-github.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/inspired-github.vim",
    url = "https://github.com/mvpopuk/inspired-github.vim"
  },
  ["iswap.nvim"] = {
    config = { "\27LJ\2\nd\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\17hl_selection\5\rautoswap\2\rhl_snipe\rErrorMsg\nsetup\niswap\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/iswap.nvim",
    url = "https://github.com/JoseConseco/iswap.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15nv-lualine\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mini.nvim"] = {
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-mini\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  neogen = {
    config = { "\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneogen\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16hide_cursor\1\nsetup\14neoscroll\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nightfox.nvim"] = {
    after = { "nvim-ts-rainbow", "hlargs.nvim", "indent-blankline.nvim" },
    loaded = true,
    only_config = true
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-null\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["numb.nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tnumb\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/numb.nvim",
    url = "https://github.com/nacro90/numb.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17nv-autopairs\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-bufferline.lua"] = {
    config = { "\27LJ\2\nR\0\0\3\0\4\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\1K\0\1\0\18nv-bufferline\nsetup\15bufferline\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua",
    url = "https://github.com/akinsho/nvim-bufferline.lua"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\vnv-cmp\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\vnv-dap\bdap\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-python"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\20/usr/bin/python\nsetup\15dap-python\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\topen\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\ncloseÊ\1\1\0\4\0\14\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\1\0B\1\2\0029\2\4\0009\2\5\0029\2\6\0023\3\b\0=\3\a\0029\2\4\0009\2\t\0029\2\n\0023\3\v\0=\3\a\0029\2\4\0009\2\t\0029\2\f\0023\3\r\0=\3\a\0022\0\0ÄK\0\1\0\0\17event_exited\0\21event_terminated\vbefore\0\17dapui_config\22event_initialized\nafter\14listeners\bdap\nsetup\ndapui\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\n¶\3\0\0\5\0\n\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\1\5\0'\3\6\0'\4\a\0B\1\3\0019\1\5\0'\3\b\0'\4\t\0B\1\3\1K\0\1\0\30DiagnosticVirtualTextWarn\30NvimDapVirtualTextChanged\30DiagnosticVirtualTextInfo\23NvimDapVirtualText\19highlight_link\15hl_manager\1\0\n\15all_frames\1\18virt_text_pos\16right_align\14commented\1\21show_stop_reason\2\29highlight_new_as_changed\2 highlight_changed_variables\2\21enabled_commands\2\fenabled\2\22virt_text_win_col\3U\15virt_lines\1\nsetup\26nvim-dap-virtual-text\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-gps"] = {
    config = { "\27LJ\2\nn\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nicons\1\0\1\14separator\n ‚ñ∂ \1\0\1\15class-name\t‚õ¨ \nsetup\rnvim-gps\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-gps",
    url = "https://github.com/SmiteshP/nvim-gps"
  },
  ["nvim-hlslens"] = {
    config = { "\27LJ\2\ng\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\14calm_down\1\17nearest_only\2\nsetup\30scrollbar.handlers.search\frequire\0" },
    load_after = {
      ["nvim-scrollbar"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/nvim-hlslens",
    url = "https://github.com/kevinhwang91/nvim-hlslens"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n#\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\blsp\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-luapad"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-luapad",
    url = "https://github.com/rafcamlet/nvim-luapad"
  },
  ["nvim-neoclip.lua"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15nv-neoclip\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/nvim-neoclip.lua",
    url = "https://github.com/AckslD/nvim-neoclip.lua"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-scrollbar"] = {
    after = { "nvim-hlslens" },
    cond = { true },
    config = { "\27LJ\2\nÏ\3\0\0\6\0\27\0#6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\t\0005\4\a\0005\5\6\0=\5\b\4=\4\n\0035\4\f\0005\5\v\0=\5\b\4=\4\r\0035\4\15\0005\5\14\0=\5\b\4=\4\16\0035\4\18\0005\5\17\0=\5\b\4=\4\19\0035\4\21\0005\5\20\0=\5\b\4=\4\22\0035\4\24\0005\5\23\0=\5\b\4=\4\25\3=\3\26\2B\0\2\1K\0\1\0\nmarks\tMisc\1\0\2\rpriority\3\5\ncolor\vpurple\1\3\0\0\6-\6=\tHint\1\0\2\rpriority\3\4\ncolor\ngreen\1\3\0\0\6-\6=\tInfo\1\0\2\rpriority\3\3\ncolor\tblue\1\3\0\0\6-\6=\tWarn\1\0\2\rpriority\3\2\ncolor\vyellow\1\3\0\0\b‚îÅ\tùù£\nError\1\0\2\rpriority\3\1\ncolor\bred\1\3\0\0\b‚îÅ\tùù£\vSearch\1\0\0\ttext\1\0\2\rpriority\3\0\ncolor\vorange\1\3\0\0\b‚îÅ\tùù£\vhandle\1\0\0\1\0\3\ttext\6 \24hide_if_all_visible\2\ncolor\f#507990\nsetup\14scrollbar\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar"
  },
  ["nvim-spectre"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-spectre",
    url = "https://github.com/windwp/nvim-spectre"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    cond = { true },
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25nv-treesittercontext\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/nvim-treesitter-context",
    url = "https://github.com/romgrk/nvim-treesitter-context"
  },
  ["nvim-ts-hint-textobject"] = {
    config = { "\27LJ\2\nÿ\1\0\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\4\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2%:lua require('tsht').nodes()<CR>\6v\1\0\2\vsilent\2\fnoremap\1*:<C-U>lua require('tsht').nodes()<CR>\6u\6o\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-ts-hint-textobject",
    url = "https://github.com/mfussenegger/nvim-ts-hint-textobject"
  },
  ["nvim-ts-rainbow"] = {
    config = { "\27LJ\2\nâ\3\0\0\a\0\19\0.6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0'\4\4\0'\5\5\0'\6\6\0B\1\5\0019\1\2\0'\3\a\0'\4\4\0'\5\b\0'\6\6\0B\1\5\0019\1\2\0'\3\t\0'\4\4\0'\5\n\0'\6\6\0B\1\5\0019\1\2\0'\3\v\0'\4\4\0'\5\f\0'\6\6\0B\1\5\0019\1\2\0'\3\r\0'\4\4\0'\5\14\0'\6\6\0B\1\5\0019\1\2\0'\3\15\0'\4\4\0'\5\16\0'\6\6\0B\1\5\0019\1\2\0'\3\17\0'\4\4\0'\5\18\0'\6\6\0B\1\5\1K\0\1\0\16rainbowcol7\f#d08770\16rainbowcol6\f#df717a\16rainbowcol5\f#b48ead\16rainbowcol4\f#6ea1ec\16rainbowcol3\f#88c0d0\16rainbowcol2\f#a3be8c\afg\16rainbowcol1\19TSPunctBracket\f#ebcb8b\29match_color_to_highlight\15hl_manager\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["nvim-window.git"] = {
    config = { "\27LJ\2\ná\1\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2+:lua require('nvim-window').pick()<CR>\v<c-w>w\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/nvim-window.git",
    url = "https://gitlab.com/yorickpeterse/nvim-window"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/oceanic-next",
    url = "https://github.com/mhartington/oceanic-next"
  },
  ["one-small-step-for-vimkind"] = {
    config = { "\27LJ\2\nZ\0\0\3\0\6\0\n6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\6\0\4\0X\1\1ÄL\0\2\0'\1\5\0L\1\2\0\014127.0.0.1\5\23Host [127.0.0.1]: \ninput\afn\bvimx\0\0\5\0\a\0\f6\0\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0B\2\2\0A\0\0\0026\1\5\0\18\3\0\0'\4\6\0B\1\3\1L\0\2\0!Please provide a port number\vassert\vPort: \ninput\afn\bvim\rtonumberL\0\2\6\0\3\0\v\18\2\0\0005\4\0\0009\5\1\1=\5\1\0049\5\2\1\14\0\5\0X\6\1Ä)\5ò\31=\5\2\4B\2\2\1K\0\1\0\tport\thost\1\0\1\ttype\vserverƒ\1\1\0\5\0\f\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0004\2\3\0005\3\4\0003\4\5\0=\4\6\0033\4\a\0=\4\b\3>\3\1\2=\2\3\0019\1\t\0003\2\v\0=\2\n\1K\0\1\0\0\tnlua\radapters\tport\0\thost\0\1\0\3\ttype\tnlua\frequest\vattach\tname&Attach to running Neovim instance\blua\19configurations\bdap\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["onedark.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/onedark.nvim",
    url = "https://github.com/ful1e5/onedark.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["pounce.nvim"] = {
    config = { "\27LJ\2\n\1\0\0\6\0\f\0\0256\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\4\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\4\0'\4\b\0005\5\v\0B\0\5\1K\0\1\0\1\0\2\tdesc\vPounce\fnoremap\2\6o\1\0\2\tdesc\vPounce\fnoremap\2\20<cmd>Pounce<cr>\6v\1\0\2\tdesc\vPounce\fnoremap\2\16:Pounce<cr>\a  \6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/pounce.nvim",
    url = "https://github.com/rlane/pounce.nvim"
  },
  ["refactoring.nvim"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19nv-refactoring\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/refactoring.nvim",
    url = "https://github.com/ThePrimeagen/refactoring.nvim"
  },
  ["spellsitter.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/spellsitter.nvim",
    url = "https://github.com/lewis6991/spellsitter.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/tami5/sqlite.lua"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope-smart-history.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope-smart-history.nvim",
    url = "https://github.com/nvim-telescope/telescope-smart-history.nvim"
  },
  ["telescope-vim-bookmarks.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope-vim-bookmarks.nvim",
    url = "https://github.com/tom-anders/telescope-vim-bookmarks.nvim"
  },
  ["telescope.nvim"] = {
    after = { "nvim-neoclip.lua" },
    loaded = true,
    only_config = true
  },
  ["telescope_sessions_picker.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/telescope_sessions_picker.nvim",
    url = "https://github.com/JoseConseco/telescope_sessions_picker.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-todo\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ultisnips = {
    config = { "\27LJ\2\nì\1\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0@autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets\bcmd&UltiSnipsRemoveSelectModeMappings\6g\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  undotree = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-bookmarks"] = {
    config = { "\27LJ\2\nµ\1\0\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\30<Plug>BookmarkPrev | zvzz\amp\1\0\1\vsilent\2\30<Plug>BookmarkNext | zvzz\amn\6n\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-bookmarks",
    url = "https://github.com/MattesGroeger/vim-bookmarks"
  },
  ["vim-case-change"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-case-change",
    url = "https://github.com/JoseConseco/vim-case-change"
  },
  ["vim-devicons"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17web-devicons\frequire\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-esearch"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-esearch",
    url = "https://github.com/eugen0329/vim-esearch"
  },
  ["vim-floaterm"] = {
    loaded = true,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-grepper"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-grepper",
    url = "https://github.com/mhinz/vim-grepper"
  },
  ["vim-localhistory"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-localhistory",
    url = "https://github.com/mg979/vim-localhistory"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-visual-multi"] = {
    config = { "\27LJ\2\nÌ\1\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0©\1\t\t\t\taug VMlens\n\t\t\t\t\t\tau!\n\t\t\t\t\t\tau User visual_multi_start lua require('vmlens').start()\n\t\t\t\t\t\tau User visual_multi_exit lua require('vmlens').exit()\n\t\t\t\taug END\n\t\t\t\bcmd\22VM_mouse_mappings\6g\bvim\0" },
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/vim-visual-multi",
    url = "https://github.com/mg979/vim-visual-multi"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17nv-which-key\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["zenbones.nvim"] = {
    loaded = true,
    path = "/home/bartosz/.local/share/nvim/site/pack/packer/start/zenbones.nvim",
    url = "https://github.com/mcchrish/zenbones.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: tokyonight.nvim
time([[Setup for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22themes.tokyonight\frequire\0", "setup", "tokyonight.nvim")
time([[Setup for tokyonight.nvim]], false)
time([[packadd for tokyonight.nvim]], true)
vim.cmd [[packadd tokyonight.nvim]]
time([[packadd for tokyonight.nvim]], false)
-- Setup for: vim-floaterm
time([[Setup for vim-floaterm]], true)
try_loadstring("\27LJ\2\nå\2\0\0\5\0\r\1\0246\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\1\0*\1\0\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0006\0\0\0009\0\1\0005\1\a\0=\1\6\0006\0\b\0'\2\t\0B\0\2\0029\1\n\0'\3\v\0'\4\f\0B\1\3\1K\0\1\0\vNormal\19FloatermBorder\19highlight_link\15hl_manager\frequire\1\t\0\0\6 \6 \6 \6 \6 \6 \6 \6 \25floaterm_borderchars\tedit\20floaterm_opener\19floaterm_width\20floaterm_height\6g\bvimõ≥ÊÃ\25Ãô≥ˇ\3\0", "setup", "vim-floaterm")
time([[Setup for vim-floaterm]], false)
time([[packadd for vim-floaterm]], true)
vim.cmd [[packadd vim-floaterm]]
time([[packadd for vim-floaterm]], false)
-- Config for: iswap.nvim
time([[Config for iswap.nvim]], true)
try_loadstring("\27LJ\2\nd\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\17hl_selection\5\rautoswap\2\rhl_snipe\rErrorMsg\nsetup\niswap\frequire\0", "config", "iswap.nvim")
time([[Config for iswap.nvim]], false)
-- Config for: nvim-ts-hint-textobject
time([[Config for nvim-ts-hint-textobject]], true)
try_loadstring("\27LJ\2\nÿ\1\0\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\4\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2%:lua require('tsht').nodes()<CR>\6v\1\0\2\vsilent\2\fnoremap\1*:<C-U>lua require('tsht').nodes()<CR>\6u\6o\20nvim_set_keymap\bapi\bvim\0", "config", "nvim-ts-hint-textobject")
time([[Config for nvim-ts-hint-textobject]], false)
-- Config for: nvim-dap-virtual-text
time([[Config for nvim-dap-virtual-text]], true)
try_loadstring("\27LJ\2\n¶\3\0\0\5\0\n\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\1\5\0'\3\6\0'\4\a\0B\1\3\0019\1\5\0'\3\b\0'\4\t\0B\1\3\1K\0\1\0\30DiagnosticVirtualTextWarn\30NvimDapVirtualTextChanged\30DiagnosticVirtualTextInfo\23NvimDapVirtualText\19highlight_link\15hl_manager\1\0\n\15all_frames\1\18virt_text_pos\16right_align\14commented\1\21show_stop_reason\2\29highlight_new_as_changed\2 highlight_changed_variables\2\21enabled_commands\2\fenabled\2\22virt_text_win_col\3U\15virt_lines\1\nsetup\26nvim-dap-virtual-text\frequire\0", "config", "nvim-dap-virtual-text")
time([[Config for nvim-dap-virtual-text]], false)
-- Config for: copilot.vim
time([[Config for copilot.vim]], true)
try_loadstring("\27LJ\2\nÄ\1\0\0\2\0\6\0\r6\0\0\0009\0\1\0+\1\2\0=\1\2\0006\0\0\0009\0\1\0+\1\2\0=\1\3\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\5\25copilot_tab_fallback\26copilot_assume_mapped\23copilot_no_tab_map\6g\bvim\0", "config", "copilot.vim")
time([[Config for copilot.vim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-todo\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15nv-lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: dial.nvim
time([[Config for dial.nvim]], true)
try_loadstring("\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-dial\frequire\0", "config", "dial.nvim")
time([[Config for dial.nvim]], false)
-- Config for: ultisnips
time([[Config for ultisnips]], true)
try_loadstring("\27LJ\2\nì\1\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\0\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0@autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets\bcmd&UltiSnipsRemoveSelectModeMappings\6g\bvim\0", "config", "ultisnips")
time([[Config for ultisnips]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
try_loadstring("\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-mini\frequire\0", "config", "mini.nvim")
time([[Config for mini.nvim]], false)
-- Config for: diffview.nvim
time([[Config for diffview.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rdiffview\frequire\0", "config", "diffview.nvim")
time([[Config for diffview.nvim]], false)
-- Config for: one-small-step-for-vimkind
time([[Config for one-small-step-for-vimkind]], true)
try_loadstring("\27LJ\2\nZ\0\0\3\0\6\0\n6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\6\0\4\0X\1\1ÄL\0\2\0'\1\5\0L\1\2\0\014127.0.0.1\5\23Host [127.0.0.1]: \ninput\afn\bvimx\0\0\5\0\a\0\f6\0\0\0006\2\1\0009\2\2\0029\2\3\2'\4\4\0B\2\2\0A\0\0\0026\1\5\0\18\3\0\0'\4\6\0B\1\3\1L\0\2\0!Please provide a port number\vassert\vPort: \ninput\afn\bvim\rtonumberL\0\2\6\0\3\0\v\18\2\0\0005\4\0\0009\5\1\1=\5\1\0049\5\2\1\14\0\5\0X\6\1Ä)\5ò\31=\5\2\4B\2\2\1K\0\1\0\tport\thost\1\0\1\ttype\vserverƒ\1\1\0\5\0\f\0\0166\0\0\0'\2\1\0B\0\2\0029\1\2\0004\2\3\0005\3\4\0003\4\5\0=\4\6\0033\4\a\0=\4\b\3>\3\1\2=\2\3\0019\1\t\0003\2\v\0=\2\n\1K\0\1\0\0\tnlua\radapters\tport\0\thost\0\1\0\3\ttype\tnlua\frequest\vattach\tname&Attach to running Neovim instance\blua\19configurations\bdap\frequire\0", "config", "one-small-step-for-vimkind")
time([[Config for one-small-step-for-vimkind]], false)
-- Config for: accelerated-jk.nvim
time([[Config for accelerated-jk.nvim]], true)
try_loadstring("\27LJ\2\n·\2\0\0\6\0\16\0\0296\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0004\5\0\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0'\4\a\0004\5\0\0B\0\5\0016\0\b\0'\2\t\0B\0\2\0029\0\n\0005\2\v\0005\3\f\0=\3\r\0024\3\3\0005\4\14\0>\4\1\3=\3\15\2B\0\2\1K\0\1\0\23deceleration_table\1\3\0\0\3¶\4\3èN\23acceleration_table\1\3\0\0\3\5\3\29\1\0\3\23acceleration_limit\3ñ\1\24enable_deceleration\1\tmode\16time_driven\nsetup\19accelerated-jk\frequire\30<Plug>(accelerated_jk_gk)\6k\30<Plug>(accelerated_jk_gj)\6j\6n\20nvim_set_keymap\bapi\bvim\0", "config", "accelerated-jk.nvim")
time([[Config for accelerated-jk.nvim]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
try_loadstring("\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\16hide_cursor\1\nsetup\14neoscroll\frequire\0", "config", "neoscroll.nvim")
time([[Config for neoscroll.nvim]], false)
-- Config for: nvim-dap-ui
time([[Config for nvim-dap-ui]], true)
try_loadstring("\27LJ\2\n\30\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\topen\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\nclose\31\0\0\2\1\1\0\4-\0\0\0009\0\0\0B\0\1\1K\0\1\0\1¿\ncloseÊ\1\1\0\4\0\14\0\0286\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0026\1\0\0'\3\1\0B\1\2\0029\2\4\0009\2\5\0029\2\6\0023\3\b\0=\3\a\0029\2\4\0009\2\t\0029\2\n\0023\3\v\0=\3\a\0029\2\4\0009\2\t\0029\2\f\0023\3\r\0=\3\a\0022\0\0ÄK\0\1\0\0\17event_exited\0\21event_terminated\vbefore\0\17dapui_config\22event_initialized\nafter\14listeners\bdap\nsetup\ndapui\frequire\0", "config", "nvim-dap-ui")
time([[Config for nvim-dap-ui]], false)
-- Config for: nightfox.nvim
time([[Config for nightfox.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16nv-nightfox\frequire\0", "config", "nightfox.nvim")
time([[Config for nightfox.nvim]], false)
-- Config for: focus.nvim
time([[Config for focus.nvim]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\venable\2\nsetup\nfocus\frequire\0", "config", "focus.nvim")
time([[Config for focus.nvim]], false)
-- Config for: aerial.nvim
time([[Config for aerial.nvim]], true)
try_loadstring("\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14nv-aerial\frequire\0", "config", "aerial.nvim")
time([[Config for aerial.nvim]], false)
-- Config for: numb.nvim
time([[Config for numb.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\tnumb\frequire\0", "config", "numb.nvim")
time([[Config for numb.nvim]], false)
-- Config for: footprints
time([[Config for footprints]], true)
try_loadstring("\27LJ\2\n∏\1\0\0\2\0\b\0\0176\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0)\1\0\0=\1\4\0006\0\0\0009\0\1\0'\1\6\0=\1\5\0006\0\0\0009\0\1\0)\1\27\0=\1\a\0K\0\1\0\27footprintsHistoryDepth\vlinear\29footprintsEasingFunction\28footprintsOnCurrentLine\f#00c0f0\20footprintsColor\6g\bvim\0", "config", "footprints")
time([[Config for footprints]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19telescope-nvim\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\n#\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\blsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: refactoring.nvim
time([[Config for refactoring.nvim]], true)
try_loadstring("\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19nv-refactoring\frequire\0", "config", "refactoring.nvim")
time([[Config for refactoring.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16nv-gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-window.git
time([[Config for nvim-window.git]], true)
try_loadstring("\27LJ\2\ná\1\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2+:lua require('nvim-window').pick()<CR>\v<c-w>w\6n\20nvim_set_keymap\bapi\bvim\0", "config", "nvim-window.git")
time([[Config for nvim-window.git]], false)
-- Config for: nvim-bufferline.lua
time([[Config for nvim-bufferline.lua]], true)
try_loadstring("\27LJ\2\nR\0\0\3\0\4\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\1K\0\1\0\18nv-bufferline\nsetup\15bufferline\frequire\0", "config", "nvim-bufferline.lua")
time([[Config for nvim-bufferline.lua]], false)
-- Config for: vim-bookmarks
time([[Config for vim-bookmarks]], true)
try_loadstring("\27LJ\2\nµ\1\0\0\6\0\n\0\0176\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\1K\0\1\0\1\0\1\vsilent\2\30<Plug>BookmarkPrev | zvzz\amp\1\0\1\vsilent\2\30<Plug>BookmarkNext | zvzz\amn\6n\20nvim_set_keymap\bapi\bvim\0", "config", "vim-bookmarks")
time([[Config for vim-bookmarks]], false)
-- Config for: neogen
time([[Config for neogen]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\vneogen\frequire\0", "config", "neogen")
time([[Config for neogen]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nº\n\0\0\6\0\30\0è\0016\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\v\0'\4\f\0005\5\r\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\14\0'\4\15\0005\5\16\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\v\0'\4\18\0005\5\19\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\14\0'\4\20\0005\5\21\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\22\0'\4\23\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\24\0'\4\25\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\26\0'\4\27\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\n\0'\3\28\0'\4\29\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\22\0'\4\23\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\24\0'\4\25\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\26\0'\4\27\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\17\0'\3\28\0'\4\29\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\22\0'\4\23\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\24\0'\4\25\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\26\0'\4\27\0004\5\0\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\28\0'\4\29\0004\5\0\0B\0\5\1K\0\1\0Ç\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>\6TÅ\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>\6tô\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>\6Fò\1<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>\6f\1\0\1\fnoremap\2\21<cmd>HopWord<cr>\1\0\1\fnoremap\2\26<cmd>HopLineStart<cr>\6v\1\0\1\fnoremap\2\17:HopWord<cr>\agw\1\0\1\fnoremap\2\22:HopLineStart<cr>\agl\6n\1\0\1\fnoremap\2\18:HopChar1<cr>\6h\6o\20nvim_set_keymap\bapi\bvim\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n&\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\vnv-cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-gps
time([[Config for nvim-gps]], true)
try_loadstring("\27LJ\2\nn\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\nicons\1\0\1\14separator\n ‚ñ∂ \1\0\1\15class-name\t‚õ¨ \nsetup\rnvim-gps\frequire\0", "config", "nvim-gps")
time([[Config for nvim-gps]], false)
-- Config for: vim-devicons
time([[Config for vim-devicons]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17web-devicons\frequire\0", "config", "vim-devicons")
time([[Config for vim-devicons]], false)
-- Config for: vim-visual-multi
time([[Config for vim-visual-multi]], true)
try_loadstring("\27LJ\2\nÌ\1\0\0\3\0\5\0\t6\0\0\0009\0\1\0)\1\1\0=\1\2\0006\0\0\0009\0\3\0'\2\4\0B\0\2\1K\0\1\0©\1\t\t\t\taug VMlens\n\t\t\t\t\t\tau!\n\t\t\t\t\t\tau User visual_multi_start lua require('vmlens').start()\n\t\t\t\t\t\tau User visual_multi_exit lua require('vmlens').exit()\n\t\t\t\taug END\n\t\t\t\bcmd\22VM_mouse_mappings\6g\bvim\0", "config", "vim-visual-multi")
time([[Config for vim-visual-multi]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: spellsitter.nvim
time([[Config for spellsitter.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0", "config", "spellsitter.nvim")
time([[Config for spellsitter.nvim]], false)
-- Config for: github-nvim-theme
time([[Config for github-nvim-theme]], true)
try_loadstring("\27LJ\2\n\v\0\0\1\0\0\0\1K\0\1\0\0", "config", "github-nvim-theme")
time([[Config for github-nvim-theme]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\n'\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\fnv-null\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\vnv-dap\bdap\frequire\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: pounce.nvim
time([[Config for pounce.nvim]], true)
try_loadstring("\27LJ\2\n\1\0\0\6\0\f\0\0256\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0'\3\4\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\n\0'\3\4\0'\4\b\0005\5\v\0B\0\5\1K\0\1\0\1\0\2\tdesc\vPounce\fnoremap\2\6o\1\0\2\tdesc\vPounce\fnoremap\2\20<cmd>Pounce<cr>\6v\1\0\2\tdesc\vPounce\fnoremap\2\16:Pounce<cr>\a  \6n\20nvim_set_keymap\bapi\bvim\0", "config", "pounce.nvim")
time([[Config for pounce.nvim]], false)
-- Config for: cmp-tabnine
time([[Config for cmp-tabnine]], true)
try_loadstring("\27LJ\2\no\0\0\4\0\4\0\b6\0\0\0'\2\1\0B\0\2\2\18\2\0\0009\0\2\0005\3\3\0B\0\3\1K\0\1\0\1\0\3\14max_lines\3d\tsort\2\20max_num_results\3\3\nsetup\23cmp_tabnine.config\frequire\0", "config", "cmp-tabnine")
time([[Config for cmp-tabnine]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-dap-python
time([[Config for nvim-dap-python]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\20/usr/bin/python\nsetup\15dap-python\frequire\0", "config", "nvim-dap-python")
time([[Config for nvim-dap-python]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17nv-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Conditional loads
time([[Conditional loading of nvim-scrollbar]], true)
  require("packer.load")({"nvim-scrollbar"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-scrollbar]], false)
time([[Conditional loading of nvim-treesitter-context]], true)
  require("packer.load")({"nvim-treesitter-context"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-treesitter-context]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-ts-rainbow ]]

-- Config for: nvim-ts-rainbow
try_loadstring("\27LJ\2\nâ\3\0\0\a\0\19\0.6\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0'\4\4\0'\5\5\0'\6\6\0B\1\5\0019\1\2\0'\3\a\0'\4\4\0'\5\b\0'\6\6\0B\1\5\0019\1\2\0'\3\t\0'\4\4\0'\5\n\0'\6\6\0B\1\5\0019\1\2\0'\3\v\0'\4\4\0'\5\f\0'\6\6\0B\1\5\0019\1\2\0'\3\r\0'\4\4\0'\5\14\0'\6\6\0B\1\5\0019\1\2\0'\3\15\0'\4\4\0'\5\16\0'\6\6\0B\1\5\0019\1\2\0'\3\17\0'\4\4\0'\5\18\0'\6\6\0B\1\5\1K\0\1\0\16rainbowcol7\f#d08770\16rainbowcol6\f#df717a\16rainbowcol5\f#b48ead\16rainbowcol4\f#6ea1ec\16rainbowcol3\f#88c0d0\16rainbowcol2\f#a3be8c\afg\16rainbowcol1\19TSPunctBracket\f#ebcb8b\29match_color_to_highlight\15hl_manager\frequire\0", "config", "nvim-ts-rainbow")

vim.cmd [[ packadd indent-blankline.nvim ]]

-- Config for: indent-blankline.nvim
try_loadstring("\27LJ\2\nØ\2\0\0\6\0\r\0\0206\0\0\0'\2\1\0B\0\2\0029\1\2\0'\3\3\0'\4\4\0005\5\5\0B\1\4\0016\1\6\0009\1\a\1'\3\b\0B\1\2\0019\1\t\0'\3\n\0'\4\v\0B\1\3\0016\1\0\0'\3\f\0B\1\2\1K\0\1\0\18nv-indentline\fComment\31IndentBlanklineContextChar\19highlight_link<highlight IndentOdd guifg=NONE guibg=NONE gui=nocombine\bcmd\bvim\1\0\2\vaction\rcontrast\vfactor\3˙ˇˇˇ\15\vNormal\15IndentEven\23highlight_from_src\15hl_manager\frequire\0", "config", "indent-blankline.nvim")

vim.cmd [[ packadd hlargs.nvim ]]

-- Config for: hlargs.nvim
try_loadstring("\27LJ\2\nè\3\0\0\a\0\26\0%6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0026\1\0\0'\3\4\0B\1\2\0029\1\5\0015\3\b\0009\4\6\0009\4\a\4=\4\t\0035\4\15\0005\5\v\0005\6\n\0=\6\f\0055\6\r\0=\6\14\5=\5\16\0045\5\18\0005\6\17\0=\6\f\0055\6\19\0=\6\14\5=\5\20\4=\4\21\3B\1\2\0016\1\0\0'\3\22\0B\1\2\0029\2\23\1'\4\24\0'\5\25\0B\2\3\1K\0\1\0\16TSParameter\vHlargs\19highlight_link\15hl_manager\22excluded_argnames\vusages\1\2\0\0\tself\1\0\0\1\3\0\0\tself\bcls\17declarations\1\0\0\blua\1\2\0\0\tself\vpython\1\0\0\1\3\0\0\tself\bcls\ncolor\1\0\1\27paint_arg_declarations\1\vbright\tcyan\nsetup\vhlargs\rnightfox\tload\21nightfox.palette\frequire\0", "config", "hlargs.nvim")

vim.cmd [[ packadd nvim-neoclip.lua ]]

-- Config for: nvim-neoclip.lua
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15nv-neoclip\frequire\0", "config", "nvim-neoclip.lua")

vim.cmd [[ packadd plenary.nvim ]]
vim.cmd [[ packadd which-key.nvim ]]

-- Config for: which-key.nvim
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17nv-which-key\frequire\0", "config", "which-key.nvim")

time([[Sequenced loading]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
