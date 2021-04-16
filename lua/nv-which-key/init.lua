local wk = require('whichkey_setup')
require("whichkey_setup").config{
    hide_statusline = false,
    default_keymap_settings = {
        silent=true,
        noremap=true,
    },
}

vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Map leader to which_key
-- nnoremap <silent> <leader> :silent WhichKey  <CR>
-- vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

-- Create map to add keys to
vim.g.which_key_sep = ">"
vim.g.timeoutlen=500
-- vim.g.which_key_use_floating_win = 1


local which_key_map = {}

-- Hide status line
-- autocmd! Filocalype which_key
-- autocmd  Filocalype which_key set laststatus=0 noshowmode noruler
  -- | autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

-- Single mappings
which_key_map['.'] = { ':Startify<CR>',         'start screen' }
which_key_map['r'] = { ':luafile $MYVIMRC<CR>', 'Reload VIMRC' }
which_key_map['c'] = { ':cd %:p:h<CR>',         'cd %' }
which_key_map[' '] = { ':HopChar2<CR>',         'HOP 2Char' }

-- s is for vim-startify
which_key_map.s = {
	name = 'Sessions' ,
	s = {':SSave<CR>', 'Sesion Save'},
	l = {':SLoad<CR>', 'Sesion Load'},
	c = {':SClose<CR>', 'Sesion Close'},
	d = {':SDelocale<CR>', 'Sesion Delete'},
}

-- n is for Quit
which_key_map.w = {
	name = 'Window' ,
	h = {'<C-W>s<CR>', 'Split below'},
	v = {'<C-W>v<CR>', 'Split right'},
	q = {'<C-W>q<CR>', 'Quit window'},
	o = {'<C-W>o<CR>', 'Close All but current'},
}



-- q is for Quit
which_key_map.q = {
	name = 'Quit' ,
	x = {':NERDTreeClose<CR>:MinimapClose<CR>:x<CR>', 'Quit Save :x (wq)'},
	q = {':NERDTreeClose<CR>:MinimapClose<CR>:confirm qa<CR>', 'Quit all (qa!)'},
	c = {':confirm q!<CR>', 'Close current (q!)'},
	s = {':NERDTreeClose<CR>:MinimapClose<CR>:wqa!<CR>', 'Quit Save all (wqa!)'},
	r = {':confirm e!<CR>', 'Reload File(e!)'}
}

-- b for buffers  - for nvim-bufferline<Plug>
which_key_map.b = {
	name = 'Buffers' ,
	[']'] = {':BufferLineCycleNext<CR>', 'Next'},
	['['] = {':BufferLineCyclePrev<CR>', 'Previous'},
	c = {':bd<CR>',                  'Close'},
	n = {':enew<CR>',                'New'},
	o = {':bufdo bd<CR>',            'Close all but current'},
	p = {':BufferLinePick<CR>',      'Pick (gb)'}
}




-- Fold All toggle
-- -- vim.api.nvim_set_keymap( "n", "<F1>",  vim.cmd([[&foldlevel:'zM?zR' ]]), { expr = true, noremap = true, silent = true } )
-- vim.api.nvim_set_keymap( "n", "<S-F1>",  'v:lua.conditional_fold()',  { expr = true, noremap = true, silent = true } )

function _G.conditional_fold()
	if vim.wo.foldlevel > 0 then
		vim.cmd('normal zM')
	else
		vim.cmd('normal zR')
	end
end

function _G.conditional_width()
	local wwidth = vim.api.nvim_eval('&winwidth')
	if wwidth > 10 then
		vim.cmd(':set winwidth=1') -- disable
	else
		vim.cmd(':set winwidth=87')
	end
end
-- below is required or else which key wont work !!
vim.api.nvim_set_keymap( "n", "<Leader>ww",  'v:lua.conditional_width()',  {expr = true, noremap = true, silent = true } )


-- F is for fold
which_key_map.f = {
	name= '+fold',
	w = {':v:lua.conditional_width()', 'Toogle auto width'},
	f = {':v:lua.conditional_fold()',  'Toggle FoldLevel'},
	C = {':zM<CR>',                             'Close all(zM)'},
	O = {':zR<CR>',                              'Open all (zR)'},
	['oc'] = {':zO<CR>',                            'Open all cursor(zM)'},
	['+'] = {':zm<CR>',                             'inc+1 (zm)'},
	['-'] = {':zr<CR>',                             'dec-1 (zr)'},
	['tc'] = {':za<CR>',                            'Toggle at cur(za)'},
	['trc'] = {':zA<CR>',                           'Toggle at cur rec(zA)'},
	['T'] = {':zi<CR>',                             'Toggle fold enable(zi)'},
	['1'] = {':set foldlevel=1<CR>',                'level1'},
	['2'] = {':set foldlevel=2<CR>',                'level2'},
	['3'] = {':set foldlevel=3<CR>',                'level3'},
	['4'] = {':set foldlevel=4<CR>',                'level4'},
	['5'] = {':set foldlevel=5<CR>',                'level5'},
	['6'] = {':set foldlevel=6<CR>',                'level6'},
	['9'] = {':set foldlevel=9<CR>',                  'level9'}
}
--  o = {':zo<CR>', 'open cur(zo)'},
--  O = {':zO<CR>', 'open all cur(zO)'},

which_key_map.t = {
	name = '+Telescope',
	['.'] = {':Telescope filocalypes<CR>', 'filetypes'},
	[';'] = {':Telescope commands<CR>', 'commands'},
	a = {':Telescope lsp_code_actions<CR>', 'code_actions'},
	A = {':Telescope builtin<CR>', 'all'},
	b = {':Telescope buffers<CR>', 'buffer name'},
	f = {':Telescope find_files<CR>', 'files'},
	F = {':Telescope git_files<CR>', 'git_files'},
	tg = {':Telescope tags<CR>', 'tags'},
	bt = {':Telescope current_buffer_tags<CR>', 'buffer_tags'},
	h = {':Telescope command_history<CR>', 'history'},
	H = {':Telescope help_tags<CR>', 'help_tags'},
	k = {':Telescope keymaps<CR>', 'keymaps'},
	l = {':Telescope loclist<CR>', 'loclist'},
	m = {':Telescope marks<CR>', 'marks'},
	o = {':Telescope vim_options<CR>', 'vim_options'},
	M = {':Telescope man_pages<CR>', 'man_pages'},
	p = {':Telescope fd<CR>', 'fd'},
	P = {':Telescope spell_suggest<CR>', 'spell_suggest'},
	s = {':Telescope git_status<CR>', 'git_status'},
	G = {':Telescope grep_string<CR>', 'Grep selection'},
	g = {':Telescope live_grep<CR>', 'Grep pwd'},
	z = {':Telescope current_buffer_fuzzy_find<CR>', 'Buffer fuzzy'},
	y = {':Telescope symbols<CR>', 'symbols'},
	R = {':Telescope reloader<CR>', 'reloader'},
	w = {':Telescope file_browser<CR>', 'buf_fuz_find'},
	u = {':Telescope colorscheme<CR>', 'colorschemes'},
}


-- g is for git
which_key_map.g = {
	name = '+git' ,
	a = {':Git add .<CR>', 'add all'},
	c = {':Git commit<CR>', 'commit'},
	d = {':Git diff<CR>', 'diff'},
	D = {':Gdiffsplit<CR>', 'diff split'},
	g = {':Ggrep<CR>', 'git grep'},
	s = {':Gstatus<CR>', 'status'},
	l = {':Git log<CR>', 'log'},
	p = {':!git push<CR>', 'push'},
	P = {':Git pull<CR>', 'pull'},
	r = {':GRemove<CR>', 'remove'},
	v = {':GV', 'view commits'},
	V = {':GV!', 'view buffer commits'},
}
--  h - taken by git_sign - hunk oper
--  A = {':Git add %<CR>', 'add current'},
--  S = {':!git status<CR>', 'status'},

-- vimspector
--  s = { '<Plug>VimspectorStepOver<CR>', '(F8)Step Over'},
--  q = { '<Plug>VimspectorStepOut<CR>', '<F9>Step Out '},
--  'si' = { '<Plug>VimspectorStepInto<CR>', '(F7)Step Into'},
--  p = { '<Plug>VimspectorPause<CR>', '(F6)Pause debugee.'},
--  l = { ':call vimspector#Launch()<CR><CR>', '(L)anuch config']
which_key_map.d = {
	name = '+Debugger',
	d = { '<Plug>VimspectorContinue<CR>',                     'Continue/Start debugging'},
	x = { '<Plug>VimspectorStop<CR>',                         'Stop debugging'} ,
	b = { '<Plug>VimspectorToggleBreakpoint<CR>',             'Toggle line breakpoint on the current line'},
	bc = { '<Plug>VimspectorToggleConditionalBreakpoint<CR>', 'Toggle conditional line breakpoint on the current line'},
	bf = { '<Plug>VimspectorAddFunctionBreakpoint<CR>',       'Add a function breakpoint for the expression under cursor'},
	rc = { '<Plug>VimspectorRunToCursor<CR>',                 'Run to Cursor'},
	R = { '<Plug>VimspectorRestart<CR>',                      'Restart debugging with the same configuration'},
	K = { '<Plug>VimspectorBalloonEval<CR>',                  'Evel popup'},
	c = { ':VimspectorReset<CR>',                             'Close vimspector interface'},
}

-- -- dap
-- s is for vim-startify
-- which_key_map.d = {
--        name = 'Debug' ,
--        c = { ":lua.require'dap'.continue()<CR>", 'Continue'},
--        n = { ":lua.require'dap'.step_over()", 'Step'},
--        s = { ":lua.require'dap'.scopes()", 'Scopes'},
--        b = { ":lua.require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))", 'Breakpoint toggle'},
--        r = { ":lua.require'dap'.repl.open()", 'REPL'},
--        }

which_key_map.R = {
	name = '+Find_Replace Far' ,
	f = {':Farr --source=vimgrep<CR>',                    'file'},
	p = {':Farr --source=rgnvim<CR>',                     'project'},
	c = {'<Plug>CtrlSFPrompt -R {regex} -G *.py<CR>',     'CtrlSF'},
	w = {'<Plug>CtrlSFCCwordPath<CR>',                    'CtrlSF Word'},
	s = {":lua.require('spectre').open_visual()<CR>", 'Spectre'}
}

-- " P is for vim-plug
-- which_key_map.p = {
--        name = '+plug',
--        i = {':PackerInstall<CR>', 'PackerInstall'},
--        s = {':PackerSync<CR>',    'PackerSync'},
--        S = {':PackerStatus<CR>',  'PackerStatus'},
--        c = {':PackerClean<CR>',   'PackerClean'},
which_key_map.o = {
	name = '+Repl',
	l = {':Luapad<CR><CR>',                     'Luapad Repl On'},
	L = {":lua.require('luapad').detach()<CR>", 'Luapad Repl Off'},
	c = {':Codi<CR>',                           'Codi Start'},
	C = {':Codi!<CR>',                          'Codi Stop'}
}



-- Register which key map

wk.register_keymap('leader', which_key_map)
