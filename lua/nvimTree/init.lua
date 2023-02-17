local api = require "nvim-tree.api"
local lib = require "nvim-tree.lib"
local view = require "nvim-tree.view"

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

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

local function change_root_to_global_cwd()
  local global_cwd = vim.fn.getcwd()
  -- local global_cwd = vim.fn.getcwd(-1, -1)
  api.tree.change_root(global_cwd)
end

local Hydra = require "hydra"

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
        preserve_window_proportions = true,
        mappings = {
            custom_only = false,
            list = {
                { key = "l", action = "edit",           action_cb = edit_or_open },
                { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
                { key = "h", action = "close_node" },
                { key = "H", action = "collapse_all",   action_cb = collapse_all },
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

local hint = [[
 _w_: cd CWD   _c_: Path yank           _/_: Filter
 _y_: Copy     _x_: Cut                 _p_: Paste
 _r_: Rename   _d_: Remove              _n_: New
 _h_: Hidden   _?_: Help
 ^
]]
-- ^ ^           _q_: exit

local nvim_tree_hydra = nil
local nt_au_group = vim.api.nvim_create_augroup("NvimTreeHydraAU", { clear = true })

local function close_nvim_tree_hydra()
  if nvim_tree_hydra then
    nvim_tree_hydra:exit()
  end
end

Hydra.spawn = {}
Hydra.spawn["nvim_tree_hydra"] = function()
  -- print("spawning")
  -- print("spawn.hydra")
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
          body = "H",
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
              { "h", api.tree.toggle_hidden_filter, { silent = true } },
              { "?", api.tree.toggle_help,          { silent = true } },
              -- { "q", nil, { exit = true, nowait = true } },
          },
      }

  nvim_tree_hydra:activate()
  vim.api.nvim_create_autocmd("BufLeave", {
      pattern = "*",
      callback = function(opts)
        -- print("closing: ft "..vim.bo[opts.buf].filetype)
        if vim.bo[opts.buf].filetype == "NvimTree" then
          -- print("au close hydra")
          close_nvim_tree_hydra() -- does not unload the keys - but hiding hydra ok...
          -- vim.api.nvim_remove_autocmd("BufEnter", )
          return true -- removes autocmd
        end
      end,
      group = nt_au_group,
  })
end

local clock = os.clock
local function sleep(n) -- seconds
  local t0 = clock()
  while clock() - t0 <= n do
  end
end

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(opts)
      -- print("leave: ft "..vim.bo[opts.buf].filetype)
      if vim.bo[opts.buf].filetype == "NvimTree" then
        -- vim.pretty_print("au: hydra - init !") -- print or sleep fixes the spawn not working
        sleep(0.28)
        -- nvim_tree_hydra:activate()
        Hydra.spawn["nvim_tree_hydra"]()
      end
      -- return true
    end,
    group = nt_au_group,
})

vim.api.nvim_set_keymap("n", "<F11>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- example of spawning hydra hotkey for give filetype...
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = "markdown" ,
-- 	callback = function(args)
--         vim.pretty_print("init!")
-- 		Hydra({
-- 			name = "Test",
--             hint = [[ _h_: hell]],
-- 			mode = "n",
-- 			body = ",",
-- 			config = {
--                 color="pink",
--                 invoke_on_body = true,
--                 hint = {type ='window'},
-- 				buffer = args.buf,
-- 			},
-- 			desc = "TRACING FROM SF",
-- 			heads = {
-- 				{ "h", function() vim.pretty_print("Hello!") end, },
-- 				{ "l", function() vim.pretty_print("TTTTT!") end, },
-- 			},
-- 		})
-- 	end,
-- })
--
