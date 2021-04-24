" nmap ? <Plug>Sneak_s    -overrided in keymappings.lua
" nmap ? <Plug>Sneak_S
" Example: Configure "f" to trigger label-mode: (space to confirm)
nnoremap <silent> f :<C-U>call sneak#wrap('',           1, 0, 1, 1)<CR>
nnoremap <silent> F :<C-U>call sneak#wrap('',           1, 1, 1, 1)<CR>
xnoremap <silent> f :<C-U>call sneak#wrap(visualmode(), 1, 0, 1, 1)<CR>
xnoremap <silent> F :<C-U>call sneak#wrap(visualmode(), 1, 1, 1, 1)<CR>
onoremap <silent> f :<C-U>call sneak#wrap(v:operator,   1, 0, 1, 1)<CR>
onoremap <silent> F :<C-U>call sneak#wrap(v:operator,   1, 1, 1, 1)<CR>
" Example: Configure "t" to trigger label-mode: (space to confirm)
nnoremap <silent> t :<C-U>call sneak#wrap('',           1, 0, 0, 1)<CR>
nnoremap <silent> T :<C-U>call sneak#wrap('',           1, 1, 0, 1)<CR>
xnoremap <silent> t :<C-U>call sneak#wrap(visualmode(), 1, 0, 0, 1)<CR>
xnoremap <silent> T :<C-U>call sneak#wrap(visualmode(), 1, 1, 0, 1)<CR>
onoremap <silent> t :<C-U>call sneak#wrap(v:operator,   1, 0, 0, 1)<CR>
onoremap <silent> T :<C-U>call sneak#wrap(v:operator,   1, 1, 0, 1)<CR>
" map s ?
" vim.api.nvim_set_keymap('n', 'f',  ':<Plug>Sneak_f'..t('<CR>'), {noremap = true, silent = true})
" vim.api.nvim_set_keymap('n', 'F',  ':<Plug>Sneak_F', {noremap = true, silent = true})
let g:sneak#label = 1
let g:sneak#s_next = 1 " can repeat sss to go next
