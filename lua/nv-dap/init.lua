local dap = require "dap"

vim.fn.sign_define("DapBreakpoint", { text = "⭘", texthl = "DiagnosticsHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🔴", texthl = "DiagnosticsError", linehl = "PmenuSel", numhl = "" })
-- vim.fn.sign_define("DapStopped", { text = "●", texthl = "DiagnosticsError", linehl = "DiagnosticsError", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "﮿", texthl = "DiagnosticsHint", linehl = "", numhl = "" })
-- require('dap-python').setup('~/.local/lib/python3.9/site-packages/') -- from vim-dap-python

-- C/C++ debugging -------------------

dap.adapters.cppdbg = {
  id = "cppdbg",
  type = "executable",
  command = "/home/bartosz/Pobrane/vscod_cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}
dap.configurations.cpp = {
  {
    name = "Launch file (cppdbg)",
    type = "cppdbg",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = true,
    setupCommands = {
      {
        text = "set debuginfod enabled on",
        description = "enable debuginfod",
        ignoreFailures = false,
      },
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = true,
      },
    },
  },
}

-- Python debugging ---------------

require("dap-python").setup "/usr/bin/python" -- from vim-dap-python
-- allow to debug eg. libraries
require("dap").configurations.python[1].justMyCode = false -- first python config => Launch file

-- Hotkeys ------------------

vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap('n','<S-F5>', ":call vimspector#Stop()<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<F6>", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-F6>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", { noremap = true })

vim.api.nvim_set_keymap("n", "<F8>", ":lua require'dap'.step_over()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F7>", ":lua require'dap'.step_into()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F9>", ":lua require'dap'.step_out()<CR>", { noremap = true })

-- auto complete for REPL
-- vim.cmd [[au FileType dap-repl lua require('dap.ext.autocompl').attach()]] -- XXX: this sheisse causes . to exit insert mode -- not needed>

local Hydra = require "hydra"

local dap_hydra = nil
local dap_au_group = vim.api.nvim_create_augroup("DapUiHydraAu", { clear = true })
local dap_ft = nil

local hint = [[
 _s_: Continue/Start  _X_: Dap Close   _b_: Breakpoint   _B_: Cond Breakpoint   _L_: Log Breakpoint
 _n_: Step            _<_: Step out    _>_: Step in      _c_: to cursor
 _x_: Quit DAP        _C_: Close UI    _K_: Eval         ^ ^
 ^
 ^ ^              _q_: Exit Hydra
]]

local function cond_breakpoint()
  dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
end

local function log_breakpoint()
  dap.set_breakpoint(nil, nil, vim.fn.input "Log point message: ")
end

local function eval_with_visual_selection()
  -- detect if in visual mode and get selected text
  -- local selected = vim.fn.getreg("v")
  local line = ""
  if vim.fn.mode() == "v" then
    local start_pos = vim.fn.getpos "v"
    local end_pos = vim.fn.getpos "."
    local start_col = start_pos[3]
    local end_col = end_pos[3]

    -- Ensure start_col is less than end_col
    if start_col > end_col then
      start_col, end_col = end_col, start_col
    end

    -- Get the current line content
    line = vim.fn.getline(start_pos[2])

    -- Extract the selection from the line
    line = string.sub(line, start_col, end_col)
  end

  if line == "" then -- nothing selected
    -- mark end pos - by going forward till we hit space, or dot, coma, etc
    -- then go back from cursor - till we hit space
    -- Get the current cursor position
    local cursor_pos = vim.fn.getpos(".")
    local line_num = cursor_pos[2]
    local col_num = cursor_pos[3]

    -- Get the current line content
    local cursor_line = vim.fn.getline(line_num)

    -- Initialize the start and end positions for the variable
    local start_pos = col_num
    local end_pos = col_num

    -- go forward till we hit break char
    local ending_break = { " ", ".", ",", "(", ")", "[", "]", "{", "}", ":", ";", "<", ">", "=", "+", "-", "*", "/", "&", "|", "!", "?", "~", "^", "%" }

    -- then go back  till we hit starting break char
    local starting_break = { " ",  ",", "(", ")", "[", "]", "{", "}", ":", ";", "<", ">", "=", "+", "-", "*", "/", "|", "!", "?", "~", "^", "%" }

               -- Helper function to check if a character is in a break list
    local function is_break_char(char, break_list)
      for _, break_char in ipairs(break_list) do
        if char == break_char then
          return true
        end
      end
      return false
    end

    -- Go forward till we hit an ending break char
    while end_pos <= #cursor_line and not is_break_char(string.sub(cursor_line, end_pos, end_pos), ending_break) do
      end_pos = end_pos + 1
    end

    -- Go backward till we hit a starting break char
    while start_pos > 1 and not is_break_char(string.sub(cursor_line, start_pos - 1, start_pos - 1), starting_break) do
      start_pos = start_pos - 1
    end

    -- Extract the variable
    line = string.sub(cursor_line, start_pos, end_pos - 1)
    print("Selected: '" .. line.. "'")

    -- line = vim.fn.expand "<cword>"
  end
  require("dapui").eval(line, { enter = true })
end

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
        float_opts = { border = 'rounded' }
      },
    },
    name = "Dap",
    mode = { "n", "x", "v" },
    body = "<leader>dh",
    heads = {
      { "s", dap.continue, { silent = true } },
      { "X", dap.close, { silent = true } }, -- close current session (This does NOT terminate the debug adapter or debugee. - for that use |dap.terminate()| or |dap.disconnect()|)
      { "b", dap.toggle_breakpoint, { silent = true } },
      { "B", cond_breakpoint, { silent = true } },
      { "L", log_breakpoint, { silent = true } },
      -- { "R", dap.repl.open, { silent = true } },
      -- { "K", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
      { "K", eval_with_visual_selection, { silent = true } },

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

-- local hydra_visible = false
Hydra.spawn = Hydra.spawn or {}
Hydra.spawn["dap_hydra"] = function()
  show_dap_hydra()

  -- somehow code below errors out on invalid target buffer- even thoug seems valid.., ond :exit()
  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(opts)
      -- print("BufEnter: buf " .. opts.buf .. " valid: " .. tostring(vim.api.nvim_buf_is_valid(opts.buf)))
      -- print("BufEnter: filetype " .. vim.bo[opts.buf].filetype .. " dap_ft: " .. dap_ft)
      -- print("dap_hydra: " .. tostring(dap_hydra))
      if dap.session() == nil then
        return true -- close autocmd
      end
      if vim.api.nvim_buf_is_valid(opts.buf) and vim.bo[opts.buf].filetype == dap_ft then
        -- print("Show dap")
        show_dap_hydra()
      else
        if dap_hydra and vim.bo[opts.buf].filetype ~= 'hydra_hint' then
          -- print("Exit dap hydra")
          dap_hydra:exit()
        end
      end
      -- return true -- finish au
    end,
    group = dap_au_group,
  })
end

dap.listeners.before.event_initialized["hydra_integration"] = function(session, body)
  print("Started", vim.inspect(session), vim.inspect(body))
  dap.set_breakpoint()
  require "dapui".open() -- has to be first - before hyrra - or errors out
  require("hydra").spawn["dap_hydra"]()
end
-- dap.listeners.before.event_exited["hydra_integration"] = function(session, body)
--   print("Started", vim.inspect(session), vim.inspect(body))
--   dap.set_breakpoint()
--   require "dapui".open() -- has to be first - before hyrra - or errors out
--   -- require("hydra").spawn["dap_hydra"]()
-- end
