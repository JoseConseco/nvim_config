vim.api.nvim_exec(
  [[
augroup MyColors
	autocmd!
	autocmd ColorScheme * highlight CustomSignsAdd guifg=#a4cf69 | highlight CustomSignsChange guifg=#63c1e6 | highlight CustomSignsDelete guifg=#d74f56
augroup END
]],
  false
)

vim.cmd [[:highlight CustomSignsAdd guifg=#a4cf69]]
vim.cmd [[:highlight CustomSignsChange guifg=#63c1e6]]
vim.cmd [[:highlight CustomSignsDelete guifg=#d74f56]]

local gitsigns = require "gitsigns"
gitsigns.setup {
  signs = {
    add = { text = "▊" }, --before fold
    change = { text = "▊" },
    delete = { text = "▊" },
    topdelete = { text = "▊" },
    changedelete = { text = "▊" },
    fold = { enable = true, hl = "GitSignsFold", text = "▋", numhl = "GitSignsFoldNr", linehl = "GitSignsFoldLn" },
  }, -- narrower ▎  , ┋, ［
  numhl = false,
  attach_to_untracked = false,
  on_attach = function(bufnr) end,
  linehl = false,
  -- keymaps = {
  --   -- Default keymap options
  --   noremap = true,
  --   buffer = true,
  --   -- ['n <leader>ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
  --   -- ['n <leader>ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
  --   -- ['n <leader>ghn'] = '<cmd>lua require\"gitsigns\".next_hunk()<CR>',
  -- },
  sign_priority = 6,
  update_debounce = 200,
  status_formatter = nil, -- Use default
}

require("foldsigns").setup { -- separate plugins from lewis - for drawing gitsigns on folded code
  include = { "GitSigns.*" },
}

local Hydra = require "hydra"

local hint = [[
 _n_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _p_: prev hunk   _u_: undo stage hunk   _K_: preview hunk   _B_: blame show full
 ^ ^              _r_: restore hunk      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: Neogit              _q_: exit
]]

-- if buffer not tacked autocmd  use gitsigns attach function
-- gitsigns.attach(bufnr, opts)
-- local git_non_tracked = vim.api.nvim_create_augroup("GitSignTrackNonTracked", { clear = true })
-- vim.api.nvim_create_autocmd({ "BufEnter"}, {
--   pattern = "*",
--   callback = function()
--     print('attaching gitsigngs')
--     gitsigns.attach(nil, {
--       file = vim.fn.expand("%:p"),
--       toplevel = vim.fn.expand("%:p"),
--       base = 'FILE' })
--   end,
--   group = git_non_tracked,
-- })

Hydra {
  hint = hint,
  config = {
    color = "pink",
    invoke_on_body = true,
    hint = {
      position = "bottom",
      float_opts = { border = 'rounded' }
    },
    desc = "Hunks",
  },
  mode = { "n", "x" },
  body = " gh",
  heads = {
    {
      "n",
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gitsigns.next_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    {
      "p",
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gitsigns.prev_hunk()
        end)
        return "<Ignore>"
      end,
      { expr = true },
    },
    { "s", ":Gitsigns stage_hunk<CR>", { silent = true } },
    { "u", gitsigns.undo_stage_hunk },
    { "r", gitsigns.reset_hunk },
    { "K", gitsigns.preview_hunk },
    { "d", gitsigns.toggle_deleted, { nowait = true } },
    { "b", gitsigns.blame_line },
    {
      "B",
      function()
        gitsigns.blame_line { full = true }
      end,
    },
    { "/", gitsigns.show, { exit = true } }, -- show the base of the file
    { "<Enter>", "<cmd>Neogit<CR>", { exit = true } },
    { "q", nil, { exit = true, nowait = true } },
  },
}
