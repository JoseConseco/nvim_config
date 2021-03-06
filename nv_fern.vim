" noremap <silent> <Leader>d :Fern . -drawer -width=35 -toggle<CR><C-w>=
" noremap <silent> <Leader>f :Fern . -drawer -reveal=% -width=35<CR><C-w>=
" noremap <silent> <Leader>. :Fern %:h -drawer -width=35<CR><C-w>=
" g:fern#disable_default_mappings=1
" a - key taken for Fern action
nnoremap <Plug>(fern-action-close-drawer) :FernDo close -drawer -stay<CR>
function! s:init_fern() abort
	nmap <buffer><silent> <Plug>(fern-action-open-and-close)
				\ <Plug>(fern-action-open)<Plug>(fern-action-close-drawer)
	nmap <buffer><expr>
				\ <Plug>(fern-my-open-expand-collapse)
				\ fern#smart#leaf(
				\   "\<Plug>(fern-action-open-and-close)",
				\   "\<Plug>(fern-action-expand)",
				\   "\<Plug>(fern-action-collapse)",
				\ )
	nmap <buffer><nowait> l <Plug>(fern-my-open-expand-collapse)
	nmap <buffer> <CR> <Plug>(fern-action-open-and-close)
	nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
	nmap <buffer> t <Plug>(fern-action-mark:toggle)j
	nmap <buffer> n <Plug>(fern-action-new-file)
	nmap <buffer> N <Plug>(fern-action-new-dir)
	nmap <buffer> x <Plug>(fern-action-remove)
	nmap <buffer> m <Plug>(fern-action-move)
	nmap <buffer> r <Plug>(fern-action-rename)
	nmap <buffer> s <Plug>(fern-action-open:split)
	nmap <buffer> v <Plug>(fern-action-open:vsplit)
	nmap <buffer> R <Plug>(fern-action-reload)
	nmap <buffer> <nowait> <C-h> <Plug>(fern-action-hidden:toggle)
	nmap <buffer> <nowait> < <Plug>(fern-action-leave)
	nmap <buffer> <nowait> > <Plug>(fern-action-enter)
endfunction

augroup FernEvents
	autocmd! *
	autocmd FileType fern call s:init_fern()
augroup END
let g:fern#renderer = "nerdfont"
