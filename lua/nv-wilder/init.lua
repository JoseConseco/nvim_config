vim.cmd([[
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
call wilder#set_option('modes', ['/', '?', ':'])

call wilder#set_option('renderer', wilder#popupmenu_renderer({ 'highlighter': wilder#basic_highlighter(), }))
]], false)
-- make magic search work \\v  + history  + fuzzy search
vim.cmd(
"call wilder#set_option('pipeline', [wilder#branch("..
	"[wilder#check({_, x -> empty(x)}),  wilder#history(), wilder#result({'draw': [{_, x -> ' ' . x}], }) ], "..
	"wilder#python_file_finder_pipeline({'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},  'dir_command': ['fd', '-td'],  'filters': ['fuzzy_filter', 'difflib_sorter'],  }),"..
	"wilder#cmdline_pipeline({ 'fuzzy': 1 }), "..
	"[{_, x -> x[:1] ==# '\\v' ? x[2:] : x} ] + wilder#search_pipeline() ,"..
")])", false)
-- call wilder#set_option('pipeline', [ wilder#branch( wilder#cmdline_pipeline(), [ {_, x -> x[:1] ==# '\v' ? x[2:] : x}, ] + wilder#search_pipeline(),), ])
-- fixes overrides messages    https://github.com/gelguy/wilder.nvim/issues/43
vim.cmd([[
	function! SetShortmessF(on) abort
	  if a:on
	    set shortmess+=F
	  else
	    set shortmess-=F
	  endif
	  return ''
	endfunction

	nnoremap <expr> : SetShortmessF(1) . ':'

	augroup WilderShortmessFix
	  autocmd!
	  autocmd CmdlineLeave * call SetShortmessF(0)
	augroup END
]])
