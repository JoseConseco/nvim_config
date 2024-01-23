-- local fb_actions = require "telescope._extensions.file_browser.actions"
local actions = require "telescope.actions"
local actions_state = require "telescope.actions.state"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local press = function(key)
  vim.api.nvim_feedkeys(t(key, true, true, true), "i", true)
end

local open_and_unfold = function(prompt_bufnr)
  local entry = actions_state.get_selected_entry()
  if entry == nil then
    return
  end
  -- vim.cmd("normal! zO")  -- schedule  this to avoid fold not found error
  actions.select_default(prompt_bufnr)
  vim.schedule(function()
    local line_data = vim.api.nvim_win_get_cursor(0) -- returns {row, col}
    if vim.fn.foldclosed(line_data[1]) ~= -1 then -- not folded
      vim.cmd("normal! zO")
    end
  end)

end

local telescope = require "telescope"
local fzf_opts = {
  fuzzy = true, -- false will only do exact matching
  override_generic_sorter = true, -- override the generic sorter
  override_file_sorter = true, -- override the file sorter
  case_mode = "smart_case", -- or "ignore_case" or "respect_case"
  -- the default case_mode is "smart_case"
}

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    -- prompt_position = "top",
    prompt_prefix = " ",
    dynamic_preview_title = true, -- show file path in preview area
    selection_caret = " ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    border = {},
    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
        prompt_position = "top",
        -- preview_width = 0.65
      },
      vertical = {
        mirror = false,
      },
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key"
        -- ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Down>"] = require("telescope.actions").cycle_history_next,
        ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
        ["<C-s>"] = actions.file_split,
        ["<C-v>"] = actions.file_vsplit,
        ["<cr>"] = open_and_unfold,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-s>"] = actions.file_split,
        ["<C-v>"] = actions.file_vsplit,
      },
    },
    file_sorter = require("telescope.sorters").get_fuzzy_file,
    file_ignore_patterns = { "__cache__/.*", "%.pyc" },
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    -- shorten_path = true,
    winblend = 0,
    color_devicons = true,
    use_less = true,
    path_display = { "smart" },
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
  pickers = {
    live_grep = {
      on_input_filter_cb = function(prompt)
        -- AND operator for live_grep like how fzf handles spaces with wildcards in rg
        return { prompt = prompt:gsub("%s", ".*") }
      end,
    },
    lsp_dynamic_workspace_symbols = {
      sorter = telescope.extensions.fzf.native_fzf_sorter(fzf_opts),
    },
  },
  extensions = {
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg" },
      find_cmd = "rg", -- find command (defaults to `fd`)
    },
    sessions_picker = {
      sessions_dir = vim.fn.stdpath "data" .. "/session/",
    },
    fzf = fzf_opts,
  },
}
local hl_manager = require "hl_manager"

hl_manager.highlight_from_src("TelescopePromptNormal", "Normal", { bg = 4 })
hl_manager.highlight_link("TelescopePromptBorder", "TelescopePromptNormal")
hl_manager.highlight_link("TelescopePromptPrefix", "TelescopePromptNormal")

hl_manager.highlight_link("TelescopePreviewTitle", "Search")
hl_manager.highlight_link("TelescopePromptTitle", "Search")
hl_manager.highlight_link("TelescopeResultsTitle", "Search")

-- hl_manager.highlight_from_src("TelescopeBorder", "Normal", { action = "contrast", factor = -2 })
hl_manager.highlight_link("TelescopeBorder", "Normal")
hl_manager.highlight_link("TelescopeNormal", "TelescopeBorder")
hl_manager.highlight_link("TelescopeMatching", "Search")

-- vim.cmd [[highlight! link TelescopeBorder Normal]]
-- vim.cmd [[highlight! link TelescopePromptNormal Normal]]
-- vim.cmd [[highlight! link TelescopePromptPrefix Normal]]
-- TelescopeBorder = { fg = "${bg_popup}", bg = "${bg_popup}" },
-- TelescopePromptBorder = { fg = "${bg_visual}", bg = "${bg_visual}" },
-- TelescopePromptNormal = { fg = "${fg_sidebar}", bg = "${bg_visual}" },
-- TelescopePromptPrefix = { fg = "${fg_sidebar}", bg = "${bg_visual}" },
-- TelescopeNormal = { fg = "${fg_sidebar}", bg = "${bg_popup}" },
-- TelescopePreviewTitle = { fg = "${bg_popup}", bg = "${green}" },
-- TelescopePromptTitle = { fg = "${bg_popup}", bg = "${green}" },
-- TelescopeResultsTitle = { fg = "${bg_popup}", bg = "${green}" },
-- TelescopeMatching = { fg = "${error}", bg = "${NONE}" },

telescope.load_extension "fzf" -- from 'nvim-telescope/telescope-fzf-native.nvim'
telescope.load_extension "media_files"
telescope.load_extension "vim_bookmarks"
telescope.load_extension "aerial"
-- telescope.load_extension "file_browser"
telescope.load_extension "sessions_picker"
telescope.load_extension "sessions_picker"
telescope.load_extension('textcase') --from text-case.nvim
-- require('telescope').load_extension('projects')
-- telescope.load_extension "smart_history" -- somethign wrong with reading history

-- local opt = {noremap = true, silent = true}
-- mappings
-- vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
-- vim.api.nvim_set_keymap( "n", "<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)

local showWorkspaceSymbols = function()
  local opts = {
    symbols = {
      "class",
      "function",
      -- "method",
    },
  }
  if vim.bo.filetype == "vim" then
    opts.symbols = { "function" }
  end
  require("telescope.builtin").lsp_dynamic_workspace_symbols(opts) -- build in tele
end
local showDocumentSymbols = function()
  local opts = {
    symbols = {
      "class",
      "function",
      -- "method",
    },
  }
  require("telescope.builtin").lsp_document_symbols(opts)
end
vim.keymap.set("n", "<F3>", showWorkspaceSymbols, { noremap = true, silent = true, desc = "Show Workspace Symbols" })
-- vim.keymap.set( "n", "<F3>", showDocumentSymbols, { noremap = true, silent = true, desc="Show Workspace Symbols" } )


