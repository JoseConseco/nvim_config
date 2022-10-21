vim.fn.sign_define("DapBreakpoint", { text = "⭘", texthl = "DiagnosticsHint", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "🔴", texthl = "DiagnosticsError", linehl = "PmenuSel", numhl = "" })
-- vim.fn.sign_define("DapStopped", { text = "●", texthl = "DiagnosticsError", linehl = "DiagnosticsError", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "﮿", texthl = "DiagnosticsHint", linehl = "", numhl = "" })
-- require('dap-python').setup('~/.local/lib/python3.9/site-packages/') -- from vim-dap-python
require("dap-python").setup "/usr/bin/python" -- from vim-dap-python

vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", { noremap = true })
-- vim.api.nvim_set_keymap('n','<S-F5>', ":call vimspector#Stop()<CR>", {noremap = true})

vim.api.nvim_set_keymap("n", "<F6>", ":lua require'dap'.toggle_breakpoint()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-F6>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ noremap = true })

vim.api.nvim_set_keymap("n", "<F8>", ":lua require'dap'.step_over()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F7>", ":lua require'dap'.step_into()<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<F9>", ":lua require'dap'.step_out()<CR>", { noremap = true })

-- auto complete for REPL
vim.cmd [[au FileType dap-repl lua require('dap.ext.autocompl').attach()]]

local Hydra = require "hydra"
local dap = require "dap"

local hint = [[
 _n_: step over   _s_: Continue/Start   _b_: Breakpoint     _K_: Eval
 _>_: step into   _x_: Quit             ^ ^                 ^ ^
 _o_: step out    _X_: Stop             ^ ^
 _c_: to cursor   _C_: Close UI
 ^
 ^ ^              _q_: exit
]]

local dap_hydra = Hydra {
	hint = hint,
	config = {
		color = "pink",
		invoke_on_body = true,
		-- buffer = 0,
		hint = {
			position = "bottom",
			border = "rounded",
		},
	},
	name = "dap",
	mode = { "n", "x" },
	body = "<leader>dh",
	heads = {
		{ "n", dap.step_over, { silent = true } },
		{ ">", dap.step_into, { silent = true } },
		{ "o", dap.step_out, { silent = true } },
		{ "c", dap.run_to_cursor, { silent = true } },
		{ "s", dap.continue, { silent = true } },
		{ "x", ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", { exit = true, silent = true } },
		{ "X", dap.close, { silent = true } },
		{ "C", ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", { silent = true } },
		{ "b", dap.toggle_breakpoint, { silent = true } },
		{ "K", ":lua require('dap.ui.widgets').hover()<CR>", { silent = true } },
		-- { 'K', ":lua require('dapui').eval(nil, {enter=true})<CR>", { silent = true } },
		-- { 'B', function() gitsigns.blame_line{ full = true } end },
		{ "q", nil, { exit = true, nowait = true } },
	},
}
local dap_group = vim.api.nvim_create_augroup("DapHydrawAuGroup", { clear = true })

Hydra.spawn = function(head)
	if head == "dap-hydra" then
		-- vim.api.nvim_create_autocmd({"BufEnter"}, { --FocusGained
		-- 	pattern = "*.py",
		-- 	callback = function()
		-- 		print('Dap activate')
		-- 		dap_hydra:activate()
		-- 	end,
		-- 	group = dap_group,
		-- })
		dap_hydra:activate()
	end
end
