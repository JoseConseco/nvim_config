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
		['stackoverflow.com'] = { takeover= 'always' },
		['github.com'] = { takeover= 'always' },
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

