let g:mapleader = " "
let g:maplocalleader = ','

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey ' '<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '>'
set timeoutlen=500


" Not a fan of floating windows for this
let g:which_key_use_floating_win = 1

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['S'] = [ ':Startify'                  , 'start screen' ]
let g:which_key_map['r'] = [ ':luafile $MYVIMRC'          , 'Reload VIMRC' ]
let g:which_key_map['c'] = [ ':cd %:p:h'                  , 'cd %' ]

 " s is for vim-startify
let g:which_key_map.s = {
      \ 'name' : 'Sessions' ,
      \ 's' : [':SSave'           , 'Sesion Save'],
      \ 'l' : [':SLoad'           , 'Sesion Load'],
      \ 'c' : [':SClose'          , 'Sesion Close'],
      \ 'd' : [':SDelete'         , 'Sesion Delete'],
      \ }

" n is for Quit
let g:which_key_map.w = {
      \ 'name' : 'Window' ,
      \ 'h' : ['<C-W>s'           , 'Split below'],
      \ 'v' : ['<C-W>v'           , 'Split right'],
      \ 'q' : ['<C-W>q'           , 'Quit window'],
      \ }

" n is for Quit
let g:which_key_map.N = {
      \ 'name' : 'NerdTree' ,
      \ 't' : [':NERDTreeToggle',  'Toggle'],
      \ 'f' : [':NERDTreeFind',    'Find'],
      \ 'c' : [':NERDTreeCWD',     'CWD'],
      \ 'r' : [':NERDTreeRefresh', 'Refresh'],
      \ }

function DisableUIElements()
	NERDTreeClose
	MinimapClose
endfunction
" q is for Quit
let g:which_key_map.q = {
      \ 'name' : 'Quit' ,
      \ 'x' : [':call DisableUIElements() | x'                , 'Quit Save :x (wq)'],
      \ 'q' : [':call DisableUIElements() | confirm qa'       , 'Quit all (qa!)'],
      \ 'c' : [':confirm q!'                                  , 'Close current (q!)'],
      \ 's' : [':call DisableUIElements() |  wqa!'            , 'Quit Save all (wqa!)'],
      \ 'r' : [':confirm e!'          , 'Reload File(e!)']
      \ }

" T for tabs
let g:which_key_map.b = {
      \ 'name' : 'Tabs/Buffer' ,
      \ 'n' : [':BufferNext'           ,'Next'],
      \ 'p' : [':BufferPrevious'       ,'Previous'],
	  \ 'c' : [':BufferClose'          ,'Close']
      \ }

" s is for search
let g:which_key_map.z = {
      \ 'name' : '+FZF' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'tf' : [':Ag'           , 'text in files (Ag)'],
      \ 't' : [':BLines'       , 'text in buffer'],
      \ 'F' : [':Files'        , 'files global'],
      \ 'f' : [':Files %:p:h'  , 'files pwd'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines in file'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'bt': [':BTags'        , 'buffer tags'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ }

 " Fold All toggle
" -- vim.api.nvim_set_keymap( "n", "<F1>",  vim.cmd([[&foldlevel:'zM'?'zR' ]]), { expr = true, noremap = true, silent = true } )
" vim.api.nvim_set_keymap( "n", "<S-F1>",  'v:lua.conditional_fold()',  { expr = true, noremap = true, silent = true } )

lua << EOF
function _G.conditional_fold()
	if vim.wo.foldlevel > 0 then
		vim.cmd(':normal zM')
	else
		vim.cmd(':normal zR')
	end
end
EOF

 " F is for fold
let g:which_key_map.f = {
    \ 'name': '+fold',
    \ 'f' : [':call v:lua.conditional_fold()'         , 'Toggle FoldLevel'],
    \ 'C' : [':zM'         , 'Close all(zM)'],
	\ 'O' : [':zR'         , 'Open all (zR)'],
    \ 'oc' : [':zO'         , 'Open all cursor(zM)'],
    \ '+' : [':zm'          , 'inc+1 (zm)'],
    \ '-' : [':zr'          , 'dec-1 (zr)'],
    \ 'tc' : [':za'          , 'Toggle at cur(za)'],
    \ 'trc' : [':zA'         , 'Toggle at cur rec(zA)'],
    \ 'T' : [':zi'          , 'Toggle fold enable(zi)'],
    \ '1' : [':set foldlevel=1'   , 'level1'],
    \ '2' : [':set foldlevel=2'   , 'level2'],
    \ '3' : [':set foldlevel=3'   , 'level3'],
    \ '4' : [':set foldlevel=4'   , 'level4'],
    \ '5' : [':set foldlevel=5'   , 'level5'],
    \ '6' : [':set foldlevel=6'   , 'level6'],
	\ '9' : [':set foldlevel=9'   , 'level9'],
    \ }
    " \ 'o' : [':zo'          , 'open cur(zo)'],
    " \ 'O' : [':zO'          , 'open all cur(zO)'],

let g:which_key_map.t = {
      \ 'name' : '+Telescope' ,
      \ '.' : [':Telescope filetypes'                   , 'filetypes'],
      \ ';' : [':Telescope commands'                    , 'commands'],
      \ 'a' : [':Telescope lsp_code_actions'            , 'code_actions'],
      \ 'A' : [':Telescope builtin'                     , 'all'],
      \ 'b' : [':Telescope buffers'                     , 'buffer name'],
      \ 'f' : [':Telescope find_files'                  , 'files'],
      \ 'F' : [':Telescope git_files'                   , 'git_files'],
      \ 'tg' : [':Telescope tags'                        , 'tags'],
      \ 'bt' : [':Telescope current_buffer_tags'         , 'buffer_tags'],
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
      \ 'G' : [':Telescope grep_string'                 , 'Grep selection'],
      \ 'g' : [':Telescope live_grep'                   , 'Grep pwd'],
	  \ 'z' : [':Telescope current_buffer_fuzzy_find'   , 'Buffer fuzzy'],
      \ 'y' : [':Telescope symbols'                     , 'symbols'],
      \ 'R' : [':Telescope reloader'                    , 'reloader'],
      \ 'w' : [':Telescope file_browser'                , 'buf_fuz_find'],
      \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
      \ }


" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'g' : [':GGrep'                            , 'git grep'],
      \ 's' : [':Gstatus'                          , 'status'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 'v' : [':GV'                               , 'view commits'],
      \ 'V' : [':GV!'                              , 'view buffer commits'],
      \ }
	  " \ 'h' - taken by git_sign - hunk oper
      " \ 'A' : [':Git add %'                        , 'add current'],
      " \ 'S' : [':!git status'                      , 'status'],

" vimspector
			" \ 's' : [ '<Plug>VimspectorStepOver'                    , '(F8)Step Over'],
			" \ 'q' : [ '<Plug>VimspectorStepOut'                     , '<F9>Step Out '],
			" \ 'si' : [ '<Plug>VimspectorStepInto'                   , '(F7)Step Into'],
			" \ 'p' : [ '<Plug>VimspectorPause'                       , '(F6)Pause debugee.'],
			" \ 'l' : [ ':call vimspector#Launch()<CR>'               , '(L)anuch config']
let g:which_key_map.d = {
            \ 'name' : '+Debugger',
			\ 'd' : [ '<Plug>VimspectorContinue',                     'Continue/Start debugging'],
			\ 'x' : [ '<Plug>VimspectorStop',                         'Stop debugging'] ,
			\ 'b' : [ '<Plug>VimspectorToggleBreakpoint',             'Toggle line breakpoint on the current line'],
            \ 'bc' : [ '<Plug>VimspectorToggleConditionalBreakpoint', 'Toggle conditional line breakpoint on the current line'],
            \ 'bf' : [ '<Plug>VimspectorAddFunctionBreakpoint',       'Add a function breakpoint for the expression under cursor'],
			\ 'rc' : [ '<Plug>VimspectorRunToCursor',                 'Run to Cursor'],
            \ 'R' : [ '<Plug>VimspectorRestart',                      'Restart debugging with the same configuration'],
			\ 'K' : [ '<Plug>VimspectorBalloonEval',                  'Evel popup'],
			\ 'c' : [ ':VimspectorReset',                             'Close vimspector interface'],
            \}

" -- dap
 " s is for vim-startify
" let g:which_key_map.d = {
"       \ 'name' : 'Debug' ,
"       \ 'c' : [ ":lua.require'dap'.continue()<CR>", 'Continue'],
"       \ 'n' : [ ":lua.require'dap'.step_over()", 'Step'],
"       \ 's' : [ ":lua.require'dap'.scopes()", 'Scopes'],
"       \ 'b' : [ ":lua.require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))", 'Breakpoint toggle'],
"       \ 'r' : [ ":lua.require'dap'.repl.open()", 'REPL'],
"       \ }



" P is for vim-plug
let g:which_key_map.p = {
      \ 'name' : '+plug',
      \ 'i' : [':PackerInstall', 'PackerInstall'],
      \ 's' : [':PackerSync',    'PackerSync'],
      \ 'S' : [':PackerStatus',  'PackerStatus'],
      \ 'c' : [':PackerClean',   'PackerClean'],
      \ }

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

