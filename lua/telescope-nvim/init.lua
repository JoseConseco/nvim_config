local fb_actions = require "telescope._extensions.file_browser.actions"
local actions = require "telescope.actions"

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local press = function(key)
  vim.api.nvim_feedkeys(t(key, true, true, true), "i", true)
end

-- prevets cycle_history_prev form appending more and more spaces
local function fix_prev(prompt_bufnr, map)
  press "<C-o>cc" -- <c-o> execute normal cmd in inset mode
  require("telescope.actions").cycle_history_prev(prompt_bufnr)
  return true
end

local function fix_next(prompt_bufnr, map)
  press "<C-o>cc" -- <c-o> execute normal cmd in inset mode
  require("telescope.actions").cycle_history_next(prompt_bufnr)
  return true
end


require("telescope").setup {
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
        ["<C-Down>"] = fix_next,
        ["<C-Up>"] = fix_prev,
      },
			n = {
				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,
				}
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
    history = { -- from nvim-telescope/telescope-smart-history.nvim plug
      path = vim.fn.stdpath "data" .. "/databases/telescope_history.sqlite3",
      limit = 100,
    },
  },
  pickers = {
    live_grep = {
      on_input_filter_cb = function(prompt)
        -- AND operator for live_grep like how fzf handles spaces with wildcards in rg
        return { prompt = prompt:gsub("%s", ".*") }
      end,
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
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    file_browser = {
      grouped = true,
      sorting_strategy = "ascending",
      mappings = {
        ["n"] = {
          ["a"] = fb_actions.create,
          ["c"] = fb_actions.create,
          ["r"] = fb_actions.rename,
          ["m"] = fb_actions.move,
          ["y"] = fb_actions.copy,
          ["d"] = fb_actions.remove,
          ["x"] = fb_actions.remove,
          ["o"] = fb_actions.open,
          ["h"] = fb_actions.goto_parent_dir,
          ["e"] = fb_actions.goto_home_dir,
          ["w"] = fb_actions.goto_cwd,
          ["t"] = fb_actions.change_cwd,
          ["b"] = fb_actions.toggle_browser,
          ["H"] = fb_actions.toggle_hidden,
          ["s"] = fb_actions.toggle_all,
          -- ["l"] = vim.api.nvim_feedkeys('<CR>'),
          ["l"] = actions.select_default,
        },
      },
    },
  },
}
local hl_manager = require "hl_manager"

hl_manager.highlight_from_src("TelescopePromptNormal", "Normal", {bg = 4 })
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

require("telescope").load_extension "fzf" -- from 'nvim-telescope/telescope-fzf-native.nvim'
require("telescope").load_extension "media_files"
require("telescope").load_extension "vim_bookmarks"
require("telescope").load_extension "aerial"
require("telescope").load_extension "file_browser"
require("telescope").load_extension "sessions_picker"
-- require('telescope').load_extension('projects')
require("telescope").load_extension "smart_history" -- somethign wrong with reading history

-- local opt = {noremap = true, silent = true}
-- mappings
-- vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
-- vim.api.nvim_set_keymap( "n", "<Leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
-- vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
