local api = require "nvim-tree.api"
local lib = require "nvim-tree.lib"
local view = require "nvim-tree.view"

local function edit_or_open()
  -- open as vsplit on current node
  local action = "edit"
  local node = lib.get_node_at_cursor()
  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
    -- view.close() -- Close the tree if file was opened
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
    -- view.close() -- Close the tree if file was opened
  end
end

local function vsplit_preview()
  -- open as vsplit on current node
  local action = "vsplit"
  local node = lib.get_node_at_cursor()
  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
  end

  -- Finally refocus on tree if it was lost
  view.focus()
end

require("nvim-tree").setup {
    reload_on_bufenter = true,
    renderer = { highlight_opened_files = "all" },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
    },
    filters = { dotfiles = true },
    view = {
        cursorline = true,
        preserve_window_proportions = true,
        mappings = {
            custom_only = false,
            list = {
                { key = "l", action = "edit",           action_cb = edit_or_open },
                { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                { key = "h", action = "close_node" },
                { key = "H", action = "collapse_all"}, -- hydra overrides it..
                -- { key = "H", action = "call_hydra", action_cb = function() Hydra.spawn('nvim_tree_hydra') end },
            },
        },
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
    },
}

-- auto show hydra on nvimtree focus
local function change_root_to_global_cwd()
  local global_cwd = vim.fn.getcwd()
  -- local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end

local hint = [[
 _w_: cd cwd   _c_: Path yank           _/_: Filter
 _y_: Copy     _x_: Cut                 _p_: Paste
 _r_: Rename   _d_: Remove              _n_: New
 _._: hidden   _?_: Help
 ^
]]
-- ^ ^           _q_: exit

local nvim_tree_hydra = nil
local nt_au_group = vim.api.nvim_create_augroup("NvimTreeHydraAu", { clear = true })

local Hydra = require "hydra"
local function spawn_nvim_tree_hydra()
  nvim_tree_hydra = Hydra {
          name = "NvimTree",
          hint = hint,
          config = {
              color = "pink",
              invoke_on_body = true,
              buffer = 0, -- only for active buffer
              hint = {
                  position = "bottom",
                  border = "rounded",
              },
          },
          mode = "n",
          -- body = "H",
          heads = {
              { "w", change_root_to_global_cwd,     { silent = true } },
              { "c", api.fs.copy.absolute_path,     { silent = true } },
              { "/", api.live_filter.start,         { silent = true } },
              { "y", api.fs.copy.node,              { silent = true } },
              { "x", api.fs.cut,                    { exit = true, silent = true } },
              { "p", api.fs.paste,                  { exit = true, silent = true } },
              { "r", api.fs.rename,                 { silent = true } },
              { "d", api.fs.remove,                 { silent = true } },
              { "n", api.fs.create,                 { silent = true } },
              -- { "H", api.tree.collapse_all, { silent = true } },
              { ".", api.tree.toggle_hidden_filter, { silent = true } },
              { "?", api.tree.toggle_help,          { silent = true } },
              -- { "q", nil, { exit = true, nowait = true } },
          },
      }
  nvim_tree_hydra:activate()
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(opts)
      -- print("leave: ft "..vim.bo[opts.buf].filetype)
      if vim.bo[opts.buf].filetype == "NvimTree" then
        spawn_nvim_tree_hydra()
      else
        -- print("au close hydra")
        if nvim_tree_hydra then
          nvim_tree_hydra:exit()
        end
        -- return true -- removes autocmd
      end
    end,
    group = nt_au_group,
})

-- vim.api.nvim_set_keymap("n", "<F11>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
