 require("trouble").setup({
	height = 10, -- height of the trouble list
	icons = true, -- use dev-icons for filenames
	mode = "document", -- "workspace" or "document"
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds

	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint = "",
		information = ""
	},
	use_lsp_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})
