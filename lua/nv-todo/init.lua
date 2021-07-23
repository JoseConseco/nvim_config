require("todo-comments").setup({
	signs = false,
	highlight = {
		before = "", -- "fg" or "bg" or empty
		keyword = "fg", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
		after = "fg", -- "fg" or "bg" or empty
		pattern = [[.*<(KEYWORDS)\s*:]], -- pattern used for highlightng (vim regex)
	},
	keywords = {
		-- TODO = { icon = " ", color = "info", alt = {"TODO", "WIP"} },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "W" } },
		HACK = { icon = " ", color = "warning", alt = {"CHECK", "FIX", "F"}},
		NOTE = { icon = " ", color = "hint", alt = { "INFO", "WIP", "N", "DONE" } },
		}
})
