require("todo-comments").setup({
	signs = false,
	highlight = {
		before = "", -- "fg" or "bg" or empty
		keyword = "fg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[\s*<(KEYWORDS):?\s+]], -- pattern used for highlightng (vim regex)
	},
	colors = {
	    error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
	    warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
	    info = { "DiagnosticInfo", "#2563EB" },
	    hint = { "DiagnosticHint", "#10B981" },
	    default = { "String", "#7C3AED" },
	},
	keywords = {
		TODO = { icon = " ", color = "hint", alt = {"TODO", "WIP"} },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX"} },
		HACK = { icon = " ", color = "warning", alt = {"CHECK", "FIX"}},
		NOTE = { icon = " ", color = "default", alt = { "INFO", "WIP", "VIP", "DONE" } },
		}
})
