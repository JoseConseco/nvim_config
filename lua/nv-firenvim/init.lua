vim.g.firenvim_config = {
	globalSettings = {
		alt = 'all',
	},
	localSettings = {
		['.*'] = {
			cmdline  = 'neovim',
			content  = 'text',
			priority = 0,
			selector = 'textarea',
			takeover = 'never',
		},
		-- Firenvim has a setting named takeover that can be set to always, empty, never, nonempty or once.
		-- When set to always, Firenvim will always take over elements for you.
		-- When set to empty, Firenvim will only take over empty elements.
		-- When set to never, Firenvim will never automatically appear, thus forcing you to use a keyboard shortcut
		-- When set to nonempty, Firenvim will only take over elements that aren't empty.
		-- When set to once, Firenvim will take over elements the first time you select them,
		['stackoverflow.com'] = { takeover= 'once' },
		['github.com'] = { takeover= 'once' },
	}
}

if vim.fn.exists('g:started_by_firenvim') == 1 then
	vim.cmd[[set showtabline=0]] -- hide tabline
	vim.cmd[[set laststatus=0]]  -- hide statusline
	-- vim.cmd[[colorscheme dayfox]]  -- hide statusline
			-- autocmd BufNew * colorscheme dayfox
  vim.cmd[[
		augroup firenvim_tweaks
			autocmd!
			" Automatically save (and thus update the text area) when editing
			autocmd TextChanged * ++nested write
			autocmd TextChangedI * ++nested write


			autocmd BufEnter github.com_*.txt set filetype=markdown
			autocmd BufEnter stackoverflow.com_*.txt,stackexchange.com_*.txt,*.stackexchange.com_*.txt set filetype=markdown
			autocmd BufEnter www.reddit.com_*.txt set filetype=markdown

			autocmd BufEnter play.golang.org_*.txt set filetype=go
			autocmd BufEnter play.rust-lang.org_*.txt set filetype=rust
		augroup END
	]]
end

