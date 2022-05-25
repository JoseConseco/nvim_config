nnoremap <buffer> <CR> <cmd>lua require'aerial'.select()<CR><cmd>AerialClose<CR>
nnoremap <buffer> l <cmd>let save_pos=getpos(".")<cr><cmd>AerialTreeCloseAll<cr><cmd>call setpos(".", save_pos)<cr><cmd>AerialTreeOpen<CR>
nnoremap <buffer> q <c-w>q
