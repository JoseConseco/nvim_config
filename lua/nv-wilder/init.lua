vim.cmd(
[[
call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"
call wilder#set_option('modes', ['/', '?', ':'])

call wilder#set_option('pipeline', [ wilder#branch( wilder#cmdline_pipeline({ 'fuzzy': 1, 'sorter': wilder#python_difflib_sorter(), }), wilder#python_search_pipeline({ 'pattern': 'fuzzy', }),), ])

call wilder#set_option('renderer', wilder#popupmenu_renderer({ 'highlighter': wilder#basic_highlighter(), }))

" make magic search work
call wilder#set_option('pipeline', [wilder#branch( wilder#cmdline_pipeline(), [{_, x -> x[:1] ==# '\v' ? x[2:] : x} ] + wilder#search_pipeline(),  ) ])

" show cmd history when empty cmd line
call wilder#set_option('pipeline', [wilder#branch([ wilder#check({_, x -> empty(x)}),  wilder#history(),  wilder#result({'draw': [{_, x -> ' ' . x}], }) ], wilder#cmdline_pipeline(),  wilder#search_pipeline()  )])
]], false)
-- call wilder#set_option('pipeline', [ wilder#branch( wilder#cmdline_pipeline(), [ {_, x -> x[:1] ==# '\v' ? x[2:] : x}, ] + wilder#search_pipeline(),), ])
