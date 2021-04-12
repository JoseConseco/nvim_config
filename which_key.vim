let g:mapleader = " "
let g:maplocalleader = ','

" Map leader to which_key
nnoremap <silent> <leader> :silent WhichKey ' '<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_sep = '>'
set timeoutlen=500
let g:which_key_use_floating_win = 1

" s:fname()- wontwork for hoteys
function CmdInput(cmd)
	let name = input("Name: ")
	exec a:cmd." ".name
endfunction

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

let g:which_key_map =  {}
" Single mappings
let g:which_key_map['S'] = [ ':Startify',             'Startify' ]
let g:which_key_map['/'] = [ ':Ag',                   'Search Project' ] "<plug>fzf
let g:which_key_map['.'] = [ ':Telescope find_files', 'Find File' ]
let g:which_key_map['<'] = [ ':Telescope buffers',    'Swith buffer' ]
let g:which_key_map["%'"] = [ ':<C-o><CR>',           'Swith to last buffer' ] "<plug>bufftabs
let g:which_key_map['r'] = [ ':luafile $MYVIMRC',     'Reload VIMRC' ]
let g:which_key_map[' '] = [ ':HopChar1',             'HOP 2Char' ]


" b for buffers  - for nvim-bufferline<Plug>
let g:which_key_map.b = {
			\ 'name' : 'Buffers' ,
			\ 'n' : [':enew',                'New'],
			\ ']' : [':BufferLineCycleNext', 'Next'],
			\ '[' : [':BufferLineCyclePrev', 'Previous'],
			\ 'c' : [':bd',                  'Close'],
			\ 'o' : [':bufdo bd',            'Close all but current'],
			\ 'p' : [':BufferLinePick',      'Pick (gb)'],
      \ 'r' : [':confirm e!',          'Reload File(e!)'],
			\ 's' : [':Telescope buffers',  'Swith by name'],
			\ }

let g:which_key_map.c = {
    \ 'name': '+code',
	\ 'f': {
		\ 'name': 'fold',
		\ 'M' : [':zM',   'Close all(zM)'],
		\ 'R': [':zR',    'Open all (zR)'],
		\ '+' : [':zm',   'inc+1 (zm)'],
		\ '-' : [':zr',   'dec-1 (zr)'],
		\ 'a' : [':za',   'Toggle at cur(za)'],
		\ 'A' : [':zA',   'Toggle at cur rec(zA)'],
		\ 'T' : [':zi',   'Toggle fold enable(zi)'],
		\ 'o' : [':zo',   'open cur(zo)'],
		\ 'O' : [':zO',   'open all cur(zO)'],
		\},
	\ 'l': {
		\ 'name' : '+lsp',
		\ 'D' : ['v:lua.vim.lsp.buf.declaration()',    'Declaration (gD)'],
		\ 'd' : ['v:lua.vim.lsp.buf.definition()',     'Definition (gd)'],
		\ 'K' : ['v:lua.vim.lsp.buf.hover()',          'Hover (K)'],
		\ 'i' : ['v:lua.vim.lsp.buf.implementation()', 'Implementation (gi)'],
		\ 'h' : ['v:lua.vim.lsp.buf.signature_help()', 'Signature Help'],
		\ 's' : ['v:lua.vim.lsp.buf.rename()',         'Rename']  ,
		\ 'r' : ['v:lua.vim.lsp.buf.references()',     'References (gr)'] ,
		\ 'f' : ['v:lua.vim.lsp.buf.formatting()',     'Formatting'] ,
		\ 'A' : ['v:lua.vim.lsp.buf.add_workspace_folder()',     'Add Workspace Folder'] ,
		\ 'R' : ['v:lua.vim.lsp.buf.remove_workspace_folder()',     'Remove Workspace Folder'] ,
		\ 'L' : [':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List Workspace Folders'] ,
		\ 'g' : {
			 \ 'name': '+diagnostics',
			 \ 'l' : ['v:lua.vim.lsp.diagnostic.show_line_diagnostics()' , 'Line'] ,
			 \ '[' : ['v:lua.vim.lsp.diagnostic.goto_prev()'    , 'Prev'] ,
			 \ ']' : ['v:lua.vim.lsp.diagnostic.goto_next()'    , 'Next'] ,
			 \ },
		\ },
\ }


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
			" \ 's' : [ '<Plug>VimspectorStepOver'                    , '(F8)Step Over'],
			" \ 'q' : [ '<Plug>VimspectorStepOut'                     , '<F9>Step Out '],
			" \ 'si' : [ '<Plug>VimspectorStepInto'                   , '(F7)Step Into'],
			" \ 'p' : [ '<Plug>VimspectorPause'                       , '(F6)Pause debugee.'],
			" \ 'l' : [ ':call vimspector#Launch()<CR>'               , '(L)anuch config']


" file
let g:which_key_map.f = {
			\ 'name' : '+File',
			\ 's' : [ ':update',                              'Save'],
			\ 'S' : [ ':call CmdInput("w")',                  'Save as'],
			\ 'd' : [ ':call delete(expand("%")) | bdelete!', 'Delete!'],
			\ 'y' : [ 'let @+=expand("%:p")',                 'Yank file location'],
			\ 'o' : [ ':!xdg-open %:p:h',                      'Open containing folder'],
			\ 'f' : [':NERDTreeFind',                         'Find in NERDTree'],
			\ 'C' : [':cd %:p:h',                             'cd %'],
			\ 'W' : [':call CmdInput("LHWrite")',             'Local History Write'],
			\ 'L' : [':LHLoad',                               'Local History Load'],
			\ 'B' : [':LHBrowse',                             'Local History Browse'],
			\ 'D' : [':LHDelete',                             'Local History Delete'],
			\ 'I' : [':LHDiff',                               'Local History Diff'],
			\}
" \ 'c' : [':NERDTreeCWD',                          'NTree CWD'],

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'g' : [':Ggrep'                            , 'git grep'],
      \ 's' : [':Gstatus'                          , 'status'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'p' : [':!git push'                   , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 'v' : [':GV'                               , 'view commits'],
      \ 'V' : [':GV!'                              , 'view buffer commits'],
      \ }
	  " \ 'h' - taken by git_sign - hunk oper
      " \ 'A' : [':Git add %'                        , 'add current'],
      " \ 'S' : [':!git status'                      , 'status'],



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

function _G.conditional_width()
	local wwidth = vim.api.nvim_eval('&winwidth')
	if wwidth > 10 then
		vim.cmd(':set winwidth=1') -- disable
	else
		vim.cmd(':set winwidth=92')
	end
end
-- below is required or else which key wont work !!
vim.api.nvim_set_keymap( "n", "<Leader>ww",  'v:lua.conditional_width()',  {expr = true, noremap = true, silent = true } )
EOF


let g:which_key_map.o = {
    \ 'name': '+Open',
		\ '/' : ['q/',                              'Search History (q/)'],
		\ 'n' : [':NERDTreeToggle',                 'NERDTree(F4)'],
		\ 'e' : [':Ex',                            'Open Explorer(Ex)'] ,
		\ 'h' : ['q:',                              'Commands History (q:)'],
		\ 'q' : [':copen',												 	'Quickfix'],
		\ 'l' : [':Luapad',                         'Luapad Repl On'],
		\ 'L' : [":lua.require('luapad').detach()", 'Luapad Repl Off'],
		\ 'c' : [':Codi',                           'Codi Start (multi lang REPL)'],
		\ 'C' : [':Codi!',                          'Codi Stop'],
    \ }


" -- dap
" let g:which_key_map.d = {
"       \ 'name' : 'Debug' ,
"       \ 'c' : [ ":lua.require'dap'.continue()<CR>", 'Continue'],
"       \ 'n' : [ ":lua.require'dap'.step_over()", 'Step'],
"       \ 's' : [ ":lua.require'dap'.scopes()", 'Scopes'],
"       \ 'b' : [ ":lua.require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))", 'Breakpoint toggle'],
"       \ 'r' : [ ":lua.require'dap'.repl.open()", 'REPL'],
"       \ }

let g:which_key_map.R = {
      \ 'name' : '+Find_Replace Far' ,
      \ 'f' : [':Farr',                    'File Farr (t)'],
      \ 'c' : ['<Plug>CtrlSFPrompt -R {regex} -G *.py',     'CtrlSF'],
      \ 'w' : ['<Plug>CtrlSFCCwordPath',                    'CtrlSF Word'],
      \ 'e' : [":lua.require('spectre').open_visual()<CR>", 'Spectre'],
      \ }

" from startify
let g:which_key_map.p = {
      \ 'name' : 'Project',
      \ 's' : [':SSave'           , 'Sesion Save'],
      \ 'l' : [':SLoad'           , 'Sesion Load'],
      \ 'c' : [':SClose'          , 'Sesion Close'],
      \ 'd' : [':SDelete'         , 'Sesion Delete'],
			\ 'g' : [':Telescope live_grep' , 'Grep pwd (Tele)'],
      \ '/' : [':Ag'           , 'Ag pwd (FZF)'],
      \ }

let g:which_key_map.t = {
			\ 'name' : 'Toggle' ,
			\ 'w' : [':v:lua.conditional_width()', 'Auto width'],
			\ 'f' : [':call v:lua.conditional_fold()',  'Folds'],
			\ 'h' : [':set hlsearch!',  'Search highlight'],
			\ }


let g:which_key_map.T = {
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
	  \ 'z' : [':Telescope current_buffer_fuzzy_find'     , 'Buffer content search fuzzy'],
      \ 'y' : [':Telescope symbols'                     , 'symbols'],
      \ 'R' : [':Telescope reloader'                    , 'reloader'],
      \ 'w' : [':Telescope file_browser'                , 'File Browser Fuzzy'],
      \ 'u' : [':Telescope colorscheme'                 , 'colorschemes'],
      \ }

" " P is for vim-plug
" let g:which_key_map.p = {
"       \ 'name' : '+plug',
"       \ 'i' : [':PackerInstall', 'PackerInstall'],
"       \ 's' : [':PackerSync',    'PackerSync'],
"       \ 'S' : [':PackerStatus',  'PackerStatus'],
"       \ 'c' : [':PackerClean',   'PackerClean'],
      \ }

" n is for Quit
let g:which_key_map.w = {
      \ 'name' : 'Window' ,
      \ '=' : ['<C-w>='           , 'Equalize(=)'],
      \ '>' : ['<C-w>>'           , 'Increase(>)'],
      \ '<' : ['<C-w><'           , 'Decrease(<)'],
      \ 'h' : ['<C-w>s'           , 'Split below(s)'],
      \ 'v' : ['<C-w>v'           , 'Split right(v)'],
      \ 'q' : ['<C-w>q'           , 'Quit window(q)'],
			\ 'O' : [':only'           , 'Close All other splits(o)'],
      \ 'o' : ['<C-w>o'           , 'Close All but current(o)'],
      \ }


function DisableUIElements()
	NERDTreeClose
	MinimapClose
endfunction

let g:which_key_map.q = {
      \ 'name' : 'Quit',
      \ 'q' : [':call DisableUIElements() | confirm qa',        'Quit safe (qa)'],
      \ 'f' : [':q!',                                           'Force Quit (q!)'],
      \ 's' : [':call DisableUIElements() | bufdo update | q!', 'Quit Save all (wqa!)'],
      \ }


" s is for search
let g:which_key_map.z = {
      \ 'name' : '+FZF' ,
      \ ';' : [':Commands'     , 'commands'],
      \ '/' : [':Ag'           , 'text in files (Ag)'],
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

" Register which key map
call which_key#register('<Space>', "g:which_key_map")

