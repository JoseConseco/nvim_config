nnoremap <buffer> <BS> <cmd>execute 'Dirbuf %:p'.repeat(':h', v:count1 + isdirectory(expand('%')))<CR>
nnoremap <buffer> <left> <cmd>execute 'Dirbuf %:p'.repeat(':h', v:count1 + isdirectory(expand('%')))<CR>
nnoremap <buffer> <right> <cmd>execute 'lua require"dirbuf".enter()'<CR>
