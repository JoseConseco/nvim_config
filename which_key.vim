let g:mapleader = " "
let g:maplocalleader = ','

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey ' '<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '-'
set timeoutlen=500

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['e'] = [ ':e ~/.config/nvim/init.vim' , 'Edit init.vim' ]
let g:which_key_map['r'] = [ ':so $MYVIMRC'               , 'Reload init.vim']

 " s is for vim-startify
let g:which_key_map.s = {
      \ 'name' : 'Sessions' ,
      \ 's' : [':SSave'           , 'Sesion Save'],
      \ 'l' : [':SLoad'           , 'Sesion Load'],
      \ 'c' : [':SClose'           , 'Sesion Close'],
      \ 'd' : [':SDelete'           , 'Sesion Delete'],
      \ }

" n is for Quit
let g:which_key_map.w = {
      \ 'name' : 'Window' ,
      \ 'h' : ['<C-W>s'           , 'split below'],
      \ 'v' : ['<C-W>v'           , 'split right'],
      \ 'q' : ['<C-W>q'           , 'close window'],
      \ }

" n is for Quit
let g:which_key_map.v = {
      \ 'name' : 'VimTree' ,
      \ 't' : [':NvimTreeToggle'           , 'Toggle'],
      \ 'f' : [':NvimTreeFindFile'    , 'Find'],
      \ 'r' : [':NvimTreeRefresh'    , 'Refresh'],
      \ }

" q is for Quit
let g:which_key_map.q = {
      \ 'name' : 'Quit' ,
      \ 'x' : [':x'           , 'Quit Save :x (wq)'],
      \ 'q' : [':qa!'         , 'Quit all (qa!)'],
      \ 'c' : [':q!'         , 'Close current (q!)'],
      \ 's' : [':wqa!'        , 'Quit Save all (wqa!)'],
      \ 'r' : [':e!'          , 'Reload File(e!)']
      \ }


" s is for search
let g:which_key_map.z = {
      \ 'name' : '+FZF' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'f' : [':Files'        , 'files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ }

 " F is for fold
let g:which_key_map.F = {
    \ 'name': '+fold',
    \ 'c' : [':zM'          , 'close all'],
    \ 'o' : [':zo'          , 'open cur(zo)'],
    \ 'O' : [':zO'          , 'open all cur(zO)'],
    \ '+' : [':zm'          , 'inc+1 (zm)'],
    \ '-' : [':zr'          , 'dec-1 (zr)'],
    \ 't' : [':za'          , 'toggle at cur(za)'],
    \ 'T' : [':zi'          , 'Toggle fold enable(zi)'],
    \ '0' : [':set foldlevel=0'   , 'level0'],
    \ '1' : [':set foldlevel=1'   , 'level1'],
    \ '2' : [':set foldlevel=2'   , 'level2'],
    \ '3' : [':set foldlevel=3'   , 'level3'],
    \ '4' : [':set foldlevel=4'   , 'level4'],
    \ '5' : [':set foldlevel=5'   , 'level5'],
    \ '6' : [':set foldlevel=6'   , 'level6'],
	\ '9' : [':set foldlevel=9'   , 'level9'],
    \ }

let g:which_key_map.t = {
      \ 'name' : '+Telescope' ,
      \ '.' : [':Telescope filetypes'                   , 'filetypes'],
      \ ';' : [':Telescope commands'                    , 'commands'],
      \ 'a' : [':Telescope lsp_code_actions'            , 'code_actions'],
      \ 'A' : [':Telescope builtin'                     , 'all'],
      \ 'b' : [':Telescope buffers'                     , 'buffers'],
      \ 'f' : [':Telescope find_files'                  , 'files'],
      \ 'F' : [':Telescope git_files'                   , 'git_files'],
      \ 'g' : [':Telescope tags'                        , 'tags'],
      \ 'G' : [':Telescope current_buffer_tags'         , 'buffer_tags'],
      \ 'h' : [':Telescope command_history'             , 'history'],
      \ 'H' : [':Telescope help_tags'                   , 'help_tags'],
      \ 'k' : [':Telescope keymaps'                     , 'keymaps'],
      \ 'l' : [':Telescope loclist'                     , 'loclist'],
      \ 'm' : [':Telescope marks'                       , 'marks'],
      \ 'o' : [':Telescope vim_options'                 , 'vim_options'],
      \ 'M' : [':Telescope man_pages'                   , 'man_pages'],
      \ 'p' : [':Telescope fd'                          , 'fd'],
      \ 'P' : [':Telescope spell_suggest'               , 'spell_suggest'],
      \ 's' : [':Telescope git_status'                  , 'git_status'],
      \ 'S' : [':Telescope grep_string'                 , 'grep_string'],
      \ 't' : [':Telescope live_grep'                   , 'text'],
      \ 'y' : [':Telescope symbols'                     , 'symbols'],
      \ 'r' : [':Telescope registers'                   , 'registers'],
      \ 'R' : [':Telescope reloader'                    , 'reloader'],
      \ 'w' : [':Telescope file_browser'                , 'buf_fuz_find'],
      \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
      \ 'z' : [':Telescope current_buffer_fuzzy_find'   , 'buf_fuz_find'],
      \ }


" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'g' : [':GGrep'                            , 'git grep'],
      \ 'G' : [':Gstatus'                          , 'status'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 't' : [':GitGutterSignsToggle'             , 'toggle signs'],
      \ 'v' : [':GV'                               , 'view commits'],
      \ 'V' : [':GV!'                              , 'view buffer commits'],
      \ }
	  " \ 'h' - taken by git_sign - hunk oper
      " \ 'A' : [':Git add %'                        , 'add current'],
      " \ 'S' : [':!git status'                      , 'status'],



" P is for vim-plug
let g:which_key_map.p = {
      \ 'name' : '+plug' ,
      \ 'i' : [':PlugInstall'              , 'install'],
      \ 'u' : [':PlugUpdate'               , 'update'],
      \ 'c' : [':PlugClean'                , 'clean'],
      \ 's' : [':source ~/.config/nvim/init.vim', 'source vimrc'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

