vim.fn.sign_define("DapBreakpoint", { text = "⭘", texthl = "DiagnosticsHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🔴", texthl = "DiagnosticsError", linehl = "PmenuSel", numhl = "" })
-- vim.fn.sign_define("DapStopped", { text = "●", texthl = "DiagnosticsError", linehl = "DiagnosticsError", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "﮿", texthl = "DiagnosticsHint", linehl = "", numhl = "" })
-- require('dap-python').setup('~/.local/lib/python3.9/site-packages/') -- from vim-dap-python

require("dap-python").setup "/usr/bin/python" -- from vim-dap-python
-- allow to debug eg. libraries
require("dap").configurations.python[1].justMyCode = false -- first python config => Launch file

vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap('n','<S-F5>', ":call vimspector#Stop()<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<F6>", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-F6>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<F8>", ":lua require'dap'.step_over()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F7>", ":lua require'dap'.step_into()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F9>", ":lua require'dap'.step_out()<CR>", { noremap = true })

-- auto complete for REPL
vim.cmd [[au FileType dap-repl lua require('dap.ext.autocompl').attach()]]

local Hydra = require "hydra"
local dap = require "dap"

local dap_hydra = nil
local dap_au_group = vim.api.nvim_create_augroup("DapUiHydraAu", { clear = true })
local dap_ft = nil

local hint = [[
 _s_: Continue/Start  _X_: Dap Close    _b_: Breakpoint     _K_: Eval
 _n_: Step            _<_: Step into    _>_: Step out       _c_: to cursor
 _x_: Quit            _C_: Close UI     ^ ^
 ^
 ^ ^              _q_: exit
]]

local function show_dap_hydra()
  dap_hydra = Hydra {
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      -- buffer = 0,  -- only for active buffer
      desc = "Dap Hydra",
      hint = {
        position = "bottom",
        border = "rounded",
      },
    },
    name = "Dap",
    mode = { "n", "x" },
    body = "<leader>dh",
    heads = {
      { "s", dap.continue, { silent = true } },
      { "X", dap.close, { silent = true } },
      { "b", dap.toggle_breakpoint, { silent = true } },
      { "K", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },

      { "n", dap.step_over, { silent = true } },
      { ">", dap.step_into, { silent = true } },
      { "<", dap.step_out, { silent = true } },
      { "c", dap.run_to_cursor, { silent = true } },
      { "x", ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", { exit = true, silent = true } },
      { "C", ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
      -- { 'K', ":lua require('dapui').eval(nil, {enter=true})<CR>", { silent = true } },
      -- { 'B', function() gitsigns.blame_line{ full = true } end },
      { "q", nil, { exit = true, nowait = true } },
    },
  }

  dap_ft = vim.bo.filetype
  dap_hydra:activate()
end

Hydra.spawn = Hydra.spawn or {}
Hydra.spawn["dap_hydra"] = function()
  show_dap_hydra()

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(opts)
      -- print("BufEnter: ft " .. (dap_ft or ""))
      if dap.session() == nil then
        return true -- close autocmd
      end
      if vim.bo[opts.buf].filetype == dap_ft then
        show_dap_hydra()
      else
        if dap_hydra then
          dap_hydra:exit()
        end
      end
      -- return true -- finish au
    end,
    group = dap_au_group,
  })
end
