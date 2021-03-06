vim.g.mapleader = " "
vim.g.maplocalleader = ','
require("which-key").setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 10, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
})
local wk = require("which-key")
-- vim.g.mapleader = " "

-- vim.g.maplocalleader = ','

-- Map leader to which_key
-- nnoremap <silent> <leader> =silent WhichKey ' '<CR>
-- vnoremap <silent> <leader> =silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

-- nnoremap <leader>RC =cfdo %s/\v<from>/toword/g <bar> update

-- Create map to add keys to
-- vim.g.which_key_sep = '>'
-- vim.g.which_key_use_floating_win = 1

-- s=fname()- wont_work for hoteys
function _G.CmdInput(cmd)
	local name = vim.fn.input('Name= ')
	vim.cmd(cmd..name)
end

-- Hide status line
-- autocmd! FileType which_key
-- autocmd  FileType which_key set laststatus=0 noshowmode noruler
--			\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

-- Single mappings
wk.register({
	['<leader>S'] = { ':Startify<CR>',                                                 'Startify' },
	-- ['<leader>/'] = { ":lua require'telescope.builtin'.live_grep{search_dirs={'%:p'}, path_display='hidden', }<CR>",       'Search Project' },
	['<leader>/'] = { ":lua require'telescope.builtin'.grep_string({})<CR>",       'Find * (Project)' },
	-- ['<leader>/'] = { ":Telescope grep_string",       'Find *' },
	['<leader>.'] = { ':Telescope find_files<CR>',                                     'Find File' },
	['<leader>:'] = { ':Telescope commands<CR>',                                       'Commands' },
	['<leader><lt>'] = {':Telescope buffers<CR>',                                      'Switch Buffer' },
	-- ['<leader>r'] = { ':luafile $MYVIMRC<CR>',                                      'Reload VIMRC' },
	['<leader> '] = { ':HopWord<CR>',                                                  'HOP 2Char' },
	['<leader>e'] = { ':Fern . -reveal=%<CR>',                                         'File Browser' },
	['<leader>p'] = { 'viw"_dP',                                                       'Paste over word' }, -- -d => without override
	['<leader>1'] = 'which_key_ignore',
	['<leader>2'] = 'which_key_ignore',
	['<leader>3'] = 'which_key_ignore',
	['<leader>4'] = 'which_key_ignore',
	['<leader>5'] = 'which_key_ignore',
	['<leader>6'] = 'which_key_ignore',
	['<leader>7'] = 'which_key_ignore',
	['<leader>8'] = 'which_key_ignore',
	['<leader>9'] = 'which_key_ignore',
})
-- wk.register({
-- 	['<leader>'] = {
-- 		['1-9'] = {
-- 			name = "Jump to Buffer"
-- 		}
-- 	}
-- })
-- wk.register('which_key_ignore'
-- wk.register('which_key_ignore'

function _G.compare_to_clipboard()
	local ftype = vim.api.nvim_eval("&filetype")
	vim.cmd("vsplit")
	vim.cmd("enew")
	vim.cmd("normal! P")
	vim.cmd("setlocal buftype=nowrite")
	vim.cmd("set filetype="..ftype)
	vim.cmd("diffthis")
	vim.cmd([[execute "normal! \<C-w>h"]])
	vim.cmd("diffthis")
end
-- b for buffers  - for nvim-bufferline<Plug>
-- ['s'] = {':BLines',                              'Search lines fzf'},
wk.register({
	['<leader>b'] = { name = '+Buffers' },
	['<leader>b/'] = {':Telescope current_buffer_fuzzy_find<CR>',                             'Search content Tele'},
	['<leader>b?'] = {':lua require"telescope".extensions.buffer_search.buffer_search{}<CR>', 'Search current nonfzf'},
	['<leader>b<'] = {":Telescope buffers<CR>", 'Find buffer' } ,
	['<leader>bn'] = {':enew<CR>',                                                            'New'},
	['<leader>b]'] = {':BufferLineCycleNext<CR>',                                             'Next'},
	['<leader>b['] = {':BufferLineCyclePrev<CR>',                                             'Previous'},
	['<leader>bc'] = {':ScrollViewDisable | confirm bd | silent! ScrollViewEnable<CR>',       'Close'},   -- fixes error on buffer close
	['<leader>bo'] = {':%bd|e#|bd#<CR>',                                                      'Close all but current'},
	['<leader>bp'] = {':BufferLinePick<CR>',                                                  'Pick (gb)'},
	['<leader>br'] = {':confirm e<CR>',                                                       'Reload File(e!)'},
	['<leader>bf'] = {':Autoformat<CR>',                                                      'Autoformat lines'},
})

-- ['c']= {
--		name= '+Changes',
--		['t'] = {':TCV',   'Toggle line changes'},
--		['D'] = {':DC',    'Disable line changes'},
--		['E'] = {':EC',    'Enable line changes'},
--		['s'] = {':CT',    'Style mode'},
--		['d'] = {':CD',    'Local Changes Diff'},
--		['f'] = {':CF',    'Fold non-changed lines'},
--		},
wk.register({
	['<leader>c'] = { name = '+Code' },
	['<leader>c.'] = {':Telescope filetypes<CR>',    'filetypes'},
	['<leader>ct'] = {':call v:lua.CmdInput("Tab /")<CR>', 'Tabularize (align)'},
	['<leader>cF'] = {':Autoformat<CR>',             'Autoformat lines'},
	['<leader>cc'] = {':TSContextToggle<CR>',             'Context toggle'}, --from treesitter-context plug
	['<leader>ca'] = {":lua require('nvim-autopairs').disable()<CR>",             'Auto-pairs disable'}, --from treesitter-context plug
	['<leader>cA'] = {":lua require('nvim-autopairs').enable()<CR>",             'Auto-pairs enable'}, --from treesitter-context plug

	['<leader>cs']= { name = '+Spell'},
	['<leader>csT'] = {':Telescope spell_suggest<CR>',         'Suggest tele'},
	['<leader>csS'] = {':setlocal spell! spelllang=en_us<CR>', 'VIM spellchecking'},
	['<leader>cst'] = {':normal ZT<CR>',                       'Toggle Spelunker(ZT)'},
	['<leader>css'] = {':normal Zl<CR>',                       'Suggest (Zl)'},
	['<leader>csa'] = {':normal Zw<CR>',                       'Add selected word'},

	['<leader>cf']= { name = '+Folds'},
	['<leader>cff'] = {':call v:lua.conditional_fold()<CR>', 'Toggle all ON/OFF'},
	['<leader>cfM'] = {'zM<CR>',                             'Close all(zM)'},
	['<leader>cfR'] = {'zR<CR>',                             'Open all (zR)'},
	['<leader>cf+'] = {'zm<CR>',                             'inc+1 (zm)'},
	['<leader>cf-'] = {'zr<CR>',                             'dec-1 (zr)'},
	['<leader>cfa'] = {'za<CR>',                             'Toggle at cur(za)'},
	['<leader>cfA'] = {'zA<CR>',                             'Toggle at cur rec(zA)'},
	['<leader>cfT'] = {'zi<CR>',                             'Toggle fold enable(zi)'},
	['<leader>cfo'] = {'zo<CR>',                             'open cur(zo)'},
	['<leader>cfO'] = {'zO<CR>',                             'open all cur(zO)'},
})

wk.register({
	['<leader>c'] = { name = '+Refactor'},
	['<leader>cf'] = {":lua require('refactoring').refactor('Extract Function')<CR>",            'Extract Function'},
}, {mode = "v", prefix = ""})

wk.register({
	['<leader>D'] = { name = '+Diff' },
	['<leader>Dc'] = {':call v:lua.compare_to_clipboard()<CR>', 'Compare to clipboard'},   -- fixes error on buffer close
	['<leader>D['] =  { '[c<CR>',                               'Prev change [c'},
	['<leader>D]'] =  { ']c<CR>',                               'Next change ]c'},
	['<leader>Do'] =  { ':diffget<CR>',                         'Obtain(do)'},
	['<leader>Dp'] =  { ':diffput<CR>',                         'Put(dp)'},
	['<leader>Dt'] =  { ':diffthis',                            'Diff This'},
	['<leader>Du'] =  { ':diffupdate',                          'Update changes'},
	['<leader>Dv'] =  { ':DiffviewOpen',                        'Diffview Open'},
	['<leader>Dw'] =  { ':windo diffthis<cr>',                  'Diff visible windows'}, --broken from scrollbar
})


wk.register({
	['<leader>d']   = { name = '+Debugger' },
	['<leader>dd']  = { ":lua require'dap'.continue()<CR>",                                             'Continue/Start debugging'} ,
	['<leader>dx']  = { ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>",              'Disconnect'} ,
	['<leader>dX']  = { ":lua require'dap'.close()<CR>",                                                'Close'} ,
	['<leader>dU']  = { ":lua require'dap'.up()<CR>",                                                   'Stack Up'} ,
	['<leader>dD']  = { ":lua require'dap'.down()<CR>",                                                 'Stack Down'} ,
	['<leader>da']  = { ":lua require'dap'.attach('0.0.0.0', 5678)<CR>",                                'Attach (localhost, 5678)'} ,
	['<leader>dl']  = { ":lua require'dap'.run_last()<CR>",                                             'Re-run Last'},
	['<leader>db']  = { ":lua require'dap'.toggle_breakpoint()<CR>",                                    'Toggle breakpoint'},
	-- ['<leader>dc']  = { ":lua require'dap'.goto_()<CR>",                                             'Run to Cursor'},
	['<leader>du']  = { ":lua require('dapui').setup()<CR>",                                            'UI Start'} ,
	['<leader>dC']  = { ":lua require('dapui').close()<CR>",                                            'UI Close'},
	['<leader>dbc'] = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", 'Conditional breakpoint'},
	['<leader>dk']  = { ":lua require'dap.ui.variables'.hover()<CR>",                                   'Eval popup'},
	['<leader>dK']  = { ":lua require('dapui').eval()<CR>",                                             'Eval window'},
	['<leader>dn']  = { ":lua require'dap'.step_over()<CR>",                                            'Step Over'},
	['<leader>dc']  = { ":lua require'dap'.run_to_cursor()<CR>",                                        'Run to Cursor'},
	['<leader>dr']  = { ":lua require'dap'.repl.toggle()<CR>",                                          'Repl Toggle'},
})

function _G.yankpath()
	vim.cmd([[let @+=expand('%:p')]])
end
-- file
wk.register({
	['<leader>f'] = { name = '+File' },
	['<leader>fs'] = { ':update<CR>',                              'Save'},
	['<leader>fS'] = { ':call v:lua.CmdInput("w ")<CR>',                 'Save as'},
	['<leader>fd'] = { ':call delete(expand("%")) | bdelete!<CR>', 'Delete!'},
	['<leader>fr'] = {':confirm e<CR>',                            'Reload File(e!)'},
	['<leader>ff'] = {':Telescope file_browser<CR>',               'File Browser (fuzzy)'},
	['<leader>fy'] = { ":call v:lua.yankpath()<CR>",               'Yank file location<CR>'},
	['<leader>fo'] = { ':!xdg-open "%:p:h"<CR>',                   'Open containing folder'},
	['<leader>ft'] = { ':!termite -d "%:p:h"<CR>',                 'Open at terminal'},
	['<leader>fC'] = {':cd %:p:h<CR>',                             'cd %'},
})


-- g is for git
wk.register({
	['<leader>g'] = { name = '+GIT' },
	['<leader>ga'] = {':Git add .<CR>'                        , 'add all'},
	['<leader>gc'] = {':Git commit<CR>'                       , 'commit'},
	['<leader>gd'] = {':Git diff<CR>'                         , 'diff'},
	['<leader>gD'] = {':Gdiffsplit<CR>'                       , 'diff split'},
	['<leader>gH'] = {':Gdiffsplit HEAD~1'                    , 'diff split to Head~1'},
	['<leader>gg'] = {':Ggrep<CR>'                            , 'git grep'},
	['<leader>gs'] = {':Git<CR>'                              , 'status'}, -- old Gitstatus  - deprecated
	['<leader>gL'] = {':Gclog<CR>'                            , 'log files revisions'},
	['<leader>gl'] = {':0Gclog<CR>'                           , 'log current file revisions'},
	['<leader>gp'] = {':!git push<CR>'                        , 'push'},
	['<leader>gP'] = {':Git pull<CR>'                         , 'pull'},
	['<leader>gr'] = {':GRemove<CR>'                          , 'remove'},
	['<leader>gv'] = {':GV<CR>'                               , 'view commits'},
	['<leader>gV'] = {':GV!<CR>'                              , 'view buffer commits'},
})
-- ['h'] - taken by git_sign - hunk oper
-- ['A'] = {':Git add %'                        , 'add current'},
-- ['S'] = {':!git status'                      , 'status'},


wk.register({
	['<leader>h'] = { name = '+History' },
	['<leader>hu'] = {':UndotreeToggle<CR>',            'Undo Tree'} ,
	['<leader>hw'] = {':call v:lua.CmdInput("LHWrite ")<CR>', 'Local History Write'},
	['<leader>hl'] = {':LHLoad<CR>',                    'Local History Load'},
	['<leader>hb'] = {':LHBrowse<CR>',                  'Local History Browse'},
	['<leader>hx'] = {':LHDelete<CR>',                  'Local History Delete'},
	['<leader>hd'] = {':LHDiff<CR>',                    'Local History Diff'},
	['<leader>hD'] = {':DiffSaved<CR>',                 'Diff with saved'},
	['<leader>hh'] = {':Gclog<CR>',                     'File rev history (fugitive)'},
})

wk.register({
	['<leader>l'] = { name = '+LSP' },
	['<leader>lD'] = {':lua vim.lsp.buf.declaration()<CR>',                                    'Declaration (gD)'},
	['<leader>ld'] = {':lua vim.lsp.buf.definition()<CR>',                                     'Definition (gd)'},
	['<leader>lK'] = {':lua vim.lsp.buf.hover()<CR>',                                          'Hover (K)'},
	['<leader>li'] = {':lua vim.lsp.buf.implementation()<CR>',                                 'Implementation (gi)'},
	['<leader>lh'] = {':lua vim.lsp.buf.signature_help()<CR>',                                 'Signature Help'},
	['<leader>ls'] = {':lua vim.lsp.buf.rename()<CR>',                                         'Rename'}  ,
	['<leader>lr'] = {':lua vim.lsp.buf.references()<CR>',                                     'References (gr)'} ,
	['<leader>lf'] = {':lua vim.lsp.buf.formatting()<CR>',                                     'Formatting'} ,
	['<leader>la'] = {':lua vim.lsp.buf.code_action()<CR>',                                    'Code Action'} ,
	['<leader>lA'] = {':lua vim.lsp.buf.add_workspace_folder()<CR>',                           'Add Workspace Folder'} ,
	['<leader>lR'] = {':lua vim.lsp.buf.remove_workspace_folder()<CR>',                        'Remove Workspace Folder'} ,
	['<leader>lL'] = {':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR><CR>', 'List Workspace Folders'} ,
	['<leader>lt'] = {':LspTroubleToggle<CR>',                                                 'Lsp Trouble Toggle'},

	['<leader>lS'] = { name = '+LSPSaga' },
	['<leader>lSf'] = {':Lspsaga lsp_finder<CR>',         'Lsp Finder'} ,
	['<leader>lSa'] = {':Lspsaga code_action<CR>',        'Code Action'} ,
	['<leader>lSK'] = {':Lspsaga hover_doc<CR>',          'Hover Doc'} ,
	['<leader>lSs'] = {':Lspsaga signature_help<CR>',     'Signature Help'} ,
	['<leader>lSr'] = {':Lspsaga rename<CR>',             'Rename'} ,
	['<leader>lSp'] = {':Lspsaga preview_definition<CR>', 'Preview Definition'} ,

	['<leader>lg'] = { name = '+diagnostics' },
	['<leader>lgl'] = {':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', 'Line'} ,
	['<leader>lg['] = {':lua vim.lsp.diagnostic.goto_prev()<CR>',             'Prev'} ,
	['<leader>lg]'] = {':lua vim.lsp.diagnostic.goto_next()<CR>',             'Next'} ,
	['<leader>lgq'] = {':lua vim.lsp.diagnostic.set_loclist()<CR>',           'Diagnostic to Loclist'} ,

	['<leader>lT'] = { name = '+Telescope' },
	['<leader>lTr'] = {':Telescope lsp_references<CR>',           'References'},
	['<leader>lTd'] = {':Telescope lsp_definitions<CR>',          'Definitions'},
	['<leader>lTa'] = {':Telescope lsp_code_actions<CR>',         'Code Actions'},
	['<leader>lTA'] = {':Telescope lsp_range_code_actions<CR>',   'Range Code Actions'},
	['<leader>lTs'] = {':Telescope lsp_document_symbols<CR>',     'Document Symbols'},
	['<leader>lTS'] = {':Telescope lsp_workspace_symbols<CR>',    'Workspace Symbols'},
	['<leader>lTD'] = {':Telescope lsp_document_diagnostics<CR>', 'Document Diagnostics'},
})


-- Fold All toggle
-- -- vim.api.nvim_set_keymap( "n", "<F1>",  vim.cmd([[&foldlevel='zM'?'zR' ]]), { expr = true, noremap = true, silent = true } )
-- vim.api.nvim_set_keymap( "n", "<S-F1>",  'v=lua.conditional_fold()',  { expr = true, noremap = true, silent = true } )

function _G.conditional_fold()
	if vim.wo.foldlevel > 0 then
		vim.cmd(';normal zM')
	else
		vim.cmd(';normal zR')
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
-- vim.api.nvim_set_keymap( "n", "<Leader>ww",  'v=lua.conditional_width()',  {expr = true, noremap = true, silent = true } )


wk.register({
	['<leader>o'] = { name = '+Open' },
	['<leader>o/'] = {'q/',                                     'Search History (q/)'},
	['<leader>o.'] = {':Fern . -reveal=%<CR>',                  'File Browse (Fern)'},
	['<leader>of'] = {':Telescope file_browser<CR>',            'File Browser (fuzzy)'},
	['<leader>oE'] = {':Ex<CR>',                                'Open Explorer(Ex)'} ,
	['<leader>oU'] = {':UndotreeToggle<CR>',                    'Undo Tree'} ,
	['<leader>oh'] = {'q:',                                     'Commands History (q:)'},
	['<leader>oq'] = {':copen<CR>',                             'Quickfix (copen)'},
	['<leader>oo'] = {':lopen<CR>',                             'Loclist (lopen)'},
	['<leader>oO'] = {':SymbolsOutline<CR>',                    'Outliner (lsp)'},
	['<leader>ol'] = {':Luapad<CR>',                            'Luapad Repl On'},
	['<leader>oL'] = {":lua.require('luapad').detach()<CR>",    'Luapad Repl Off'},
	['<leader>oc'] = {':Codi<CR>',                              'Codi Start (multi lang REPL)'},
	['<leader>oC'] = {':Codi!<CR>',                             'Codi Stop'},
	['<leader>oT'] = {':ToggleTerm<CR>', 'Term'},
})

-- function _G.replace_word()
--	local name = vim.fn.input('To: ')
--	vim.cmd(":.,$s/\\<"..vim.fn.expand('<cword>').."\\>/"..name.."/gc|1,''-&&") -- substitute and ask each time
-- end
wk.register({
	['<leader>R'] = { name = '+Replace' },
	['<leader>Rp'] = { name = '+Project' },
	['<leader>Rpf'] = {':Farr<CR>',                                 'File Farr'},
	['<leader>Rpe'] = {'<plug>(operator-esearch-prefill)<CR>',      'Esearch'},   -- seems to be maintained
	['<leader>Rpc'] = {'<Plug>CtrlSFPrompt -R {regex} -G *.py<CR>', 'CtrlSF'},
	['<leader>Rpw'] = {'<Plug>CtrlSFCCwordPath<CR>',                'CtrlSF Word'},
	['<leader>Rps'] = {":lua require('spectre').open()<CR>",        'Spectre'},
	-- ['<leader>R*'] = {":let @/=expand('<cword>')<cr>cgn",        'Replace word with yank'},
	['<leader>R*'] = {":.,$s/\\<<C-r><C-w>\\>/<C-r>+/gc|1,''-&&<CR>",  'Replace word with yank', mode='n'},       -- \<word\>  -adds whitespace  word limit (sub only whole words)
	['<leader>R/'] = {function() local name = vim.fn.input('To: ', vim.fn.expand('<cword>')); vim.cmd(":.,$s/\\<"..vim.fn.expand('<cword>').."\\>/"..name.."/gc|1,''-&&") end,                'Replace word'},       -- write to reg z (@a) then use it for replacign * word
})
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

wk.register({  -- second one for visual mode
	['<leader>R'] = { name = '+Replace'},
	['<leader>R*'] = {"\"ay:.,$s/<C-r>a/<C-r>+/gc|1,''-&&<CR>",					 'Replace word with yank'},    -- \<word\>  -adds whitespace  word limit (sub only whole words)
	['<leader>R/'] = {function() vim.cmd("normal! \"ay"); local name = vim.fn.input('To: ', vim.fn.getreg('a')); vim.cmd(":.,$s/"..vim.fn.getreg('a').."/"..name.."/gc|1,''-&&") end ,					 'Replace word'},    -- \<word\>  -adds whitespace  word limit (sub only whole words)
}, {mode = "v", prefix = ""})


wk.register({
	['<leader>P'] = { name = '+Project' },
	['<leader>P*'] = {':Telescope grep_string<CR>',                                     'Find Word'}    ,
	['<leader>P/'] = {':Grepper-cword<CR>',                                             'Word to clist (Grepper)'},
	['<leader>Ps'] = {':SSave<CR>',                                                     'Sesion Save'}  ,
	['<leader>Pl'] = {':SLoad<CR>',                                                     'Sesion Load'}  ,
	['<leader>Pc'] = {':SClose<CR>',                                                    'Sesion Close'} ,
	['<leader>Pd'] = {':SDelete<CR>',                                                   'Sesion Delete'},
	['<leader>Pf'] = {':Telescope live_grep<CR>',                                       'Find (live grep)'}     ,
	['<leader>Pz'] = {":lua require'telescope.builtin'.grep_string{shorten_path = true, word_match = '-w', only_sort_text = true, search = '' }<CR>", 'Find fuzzy'},
})



wk.register({
	['<leader>t'] = { name = '+Telescope' },
	['<leader>tA'] = {':Telescope builtin<CR>'                     , 'all'},
	['<leader>tf'] = {':Telescope find_files<CR>'                  , 'files'},
	['<leader>tF'] = {':Telescope git_files<CR>'                   , 'git_files'},
	['<leader>tT'] = {':Telescope tags<CR>'                        , 'tags'},
	['<leader>tt'] = {':Telescope current_buffer_tags<CR>'         , 'buffer_tags'},
	['<leader>th'] = {':Telescope command_history<CR>'             , 'history'},
	['<leader>tH'] = {':Telescope help_tags<CR>'                   , 'help_tags'},
	['<leader>tk'] = {':Telescope keymaps<CR>'                     , 'keymaps'},
	['<leader>tl'] = {':Telescope loclist<CR>'                     , 'loclist'},
	['<leader>tm'] = {':Telescope marks<CR>'                       , 'marks'},
	['<leader>to'] = {':Telescope vim_options<CR>'                 , 'vim_options'},
	['<leader>tM'] = {':Telescope man_pages<CR>'                   , 'man_pages'},
	['<leader>tp'] = {':Telescope fd<CR>'                          , 'fd'},
	['<leader>tP'] = {':Telescope spell_suggest<CR>'               , 'spell_suggest'},
	['<leader>ts'] = {':Telescope git_status<CR>'                  , 'git_status'},
	['<leader>tG'] = {':Telescope grep_string<CR>'                 , 'Find Word pwd'},
	['<leader>ty'] = {':Telescope symbols<CR>'                     , 'symbols'},
	['<leader>tR'] = {':Telescope reloader<CR>'                    , 'reloader'},
	['<leader>tw'] = {':Telescope file_browser<CR>'                , 'File Browser Fuzzy'},
})


wk.register({
	['<leader>u'] = { name = '+UI' },
	['<leader>uw'] = {':call v:lua.conditional_width()<CR>',       'Auto width'},
	['<leader>uc'] = {':Telescope colorscheme<CR>'          , 'Colorscheme'},
	['<leader>uh'] = {':set hlsearch!<CR>',                   'Search highlight'},
})


-- n is for Window
wk.register({
	['<leader>w'] = { name = '+Window' },
	['<leader>w='] = {'<C-w>=<CR>',                 'Equalize(=)'},
	['<leader>w>'] = {':vertical resize +25<CR>',    'Increase(>)'},
	['<leader>w<lt>'] = {':vertical resize -25<CR>', 'Decrease(<)'},
	['<leader>wh'] = {'<C-w>s<CR>',                 'Split below(s)'},
	['<leader>wv'] = {'<C-w>v<CR>',                 'Split right(v)'},
	['<leader>wq'] = {'<C-w>q<CR>',                 'Quit window(q)'},
	['<leader>wO'] = {':only<CR>',                  'Close All other splits(o)'},
	['<leader>wo'] = {'<C-w>o<CR>',                 'Close All but current(o)'},
	['<leader>ww'] = {':call v:lua.CmdInput(":set winwidth=")<CR>',  'Set width'},
	['<leader>wm'] = {':call v:lua.CmdInput(":set winminwidth=")<CR>',  'Set min width'},
	['<leader>wa'] = {':call v:lua.conditional_width()<CR>',       'Auto width'},
})

-- TSContextDisable - if srom treesitter-context
wk.register({
	['<leader>q'] = { name = '+Quit' },
	['<leader>qq'] = {':FernDo close<CR>| :TSContextDisable<cr> | :confirm qa<CR>',        'Quit Confirm (qa)'},
	['<leader>qf'] = {':q!<CR>',                                    'Force Quit (q!)'},
	['<leader>qs'] = {':FernDo close<CR> | :bufdo update | q!<CR>', 'Quit Save all (wqa!)'},
})


-- Register which key map

-- function! s=DiffWithSaved()
--	let filetype=&ft
--	diffthis
--	vnew | r # | normal! 1Gdd
--	diffthis
--	exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=-- . filetype
-- end
-- com! DiffSaved call s=DiffWithSaved()
