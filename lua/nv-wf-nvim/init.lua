require("wf").setup()
local which_key = require "wf.builtin.which_key"
local register = require "wf.builtin.register"
local bookmark = require "wf.builtin.bookmark"
local buffer = require "wf.builtin.buffer"
local mark = require "wf.builtin.mark"

-- Register
vim.keymap.set(
  "n",
  "<Space>wr",
  -- register(opts?: table) -> function
  -- opts?: option
  register(),
  { noremap = true, silent = true, desc = "[wf.nvim] register" }
)

-- Bookmark
vim.keymap.set(
  "n",
  "<Space>wbo",
  -- bookmark(bookmark_dirs: table, opts?: table) -> function
  -- bookmark_dirs: directory or file paths
  -- opts?: option
  bookmark {
    nvim = "~/.config/nvim",
    zsh = "~/.zshrc",
  },
  { noremap = true, silent = true, desc = "[wf.nvim] bookmark" }
)

-- Buffer
vim.keymap.set(
  "n",
  "<Space>wbu",
  -- buffer(opts?: table) -> function
  -- opts?: option
  buffer(),
  { noremap = true, silent = true, desc = "[wf.nvim] buffer" }
)

-- Mark
vim.keymap.set(
  "n",
  "'",
  -- mark(opts?: table) -> function
  -- opts?: option
  mark(),
  { nowait = true, noremap = true, silent = true, desc = "[wf.nvim] mark" }
)

-- -- Which Key
-- vim.keymap.set(
--   "n",
--   " ",
--   -- mark(opts?: table) -> function
--   -- opts?: option
--   which_key { text_insert_in_advance = " " },
--   { noremap = true, silent = true, desc = "[wf.nvim] which-key /" }
-- )


if _G.__key_prefixes == nil then
  _G.__key_prefixes = {
    n = {},
  }
end

_G.__key_prefixes["n"]["<leader>u"] = "+UI"
vim.keymap.set("n", "<leader>u", ":call v:lua.conditional_width()<CR>")
vim.keymap.set("n", "<leader>uw", ":call wrap!<CR>")
vim.keymap.set("n", "<leader>ul", ":call list!<CR>")
vim.keymap.set("n", "<leader>uc", ":Telescope colorscheme<CR>")
vim.keymap.set("n", "<leader>uh", ":set hlsearch!<CR>")
vim.keymap.set("n", "<leader>uf", ":FocusToggle!<CR>")
vim.keymap.set("n", "<leader>ut", ":Twilight!<CR>")


_G.__key_prefixes["n"]["<leader>w"] = "+Window"
vim.keymap.set("n", "<leader>w=", "<C-w>=<CR>")
vim.keymap.set("n", "<leader>w>", ":vertcal resize +25<CR>")
vim.keymap.set("n", "<leader>w<lt>", ":vertcal resize -25<CR>")
vim.keymap.set("n", "<leader>wh", "<C-w>s<CR>")
vim.keymap.set("n", "<leader>wv", "<C-w>v<CR>")
vim.keymap.set("n", "<leader>wq", "<C-w>q<CR>")
vim.keymap.set("n", "<leader>wO", ":only<CR>")
vim.keymap.set("n", "<leader>wo", "<C-w>o<CR>")
vim.keymap.set("n", "<leader>ww", "<C-w>v<CR>")
vim.keymap.set("n", "<leader>wa", ": call v:lua.conditional_width()<CR>")


vim.keymap.set("n", " ", which_key({text_insert_in_advance = "\\", key_group_dict = _G.__key_prefixes["n"]}))
