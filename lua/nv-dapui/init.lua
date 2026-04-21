require("dapui").setup {
	layouts = {
		{
			-- You can change the order of elements in the sidebar
			elements = {
				{ id = "repl",        size = 0.5 },
				-- { id = "console", size = 0.5 },
				{ id = "watches", size = 0.5 },
			},
			size = 14,
			position = "bottom", -- Can be "left", "right", "top", "bottom"
		},
		{
			-- You can change the order of elements in the sidebar
			elements = {
				-- Provide as ID strings or tables with "id" and "size" keys
				-- { id = "watches", size = 0.5 },
				{ id = "scopes",  size = 0.2 },
				{ id = "stacks",  size = 0.2 },
				{ id = "breakpoints", size = 0.4 },
			},
			size = 40,
			position = "left", -- Can be "left", "right", "top", "bottom"
		},
	},
}
local function cleanup_dap_repl_buffers()
	local bufs = vim.api.nvim_list_bufs()
	for _, buf in ipairs(bufs) do
		local name = vim.api.nvim_buf_get_name(buf)
		if name:match("dap%-repl%-") then
			if vim.api.nvim_buf_is_valid(buf) then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end
end


local dap, dapui = require "dap", require "dapui"
-- dap.listeners.after.event_initialized["dapui_config"] = function() -- done in dap hydra init evet
--   -- cleanup_dap_repl_buffers() -- breaks repl...
--   dapui.open()
-- end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
	cleanup_dap_repl_buffers()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
    -- searc for stray - dap-repl-xyz buffers and delete/remove them
	cleanup_dap_repl_buffers()
end
