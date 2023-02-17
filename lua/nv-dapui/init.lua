require("dapui").setup {
  layout = {
		{
			-- You can change the order of elements in the sidebar
			elements = {
				-- Provide as ID strings or tables with "id" and "size" keys
				{ id = "scopes", size = 0.5 },
				{ id = "watches", size = 0.2 },
				{ id = "stacks", size = 0.2 },
				{ id = "breakpoints", size = 0.1 },
			},
			size = 40,
			position = "left", -- Can be "left", "right", "top", "bottom"
		},
		{
			-- You can change the order of elements in the sidebar
			elements = {
				'repl',
				'console',
			},
			size = 20,
			position = "bottom", -- Can be "left", "right", "top", "bottom"
		},
  },
}
local dap, dapui = require "dap", require "dapui"
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
