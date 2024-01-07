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
	local name = vim.fn.input('Name: ')
	-- eg: cmd =  string.format('Script Name: "%s"', name)
	local full_cmd = string.format(cmd, name)
	print(full_cmd)
	vim.cmd( full_cmd)
end

local function search_unfolded()
	-- skip folded lines (wont work with nN remaps and hlslens)
	vim.opt.foldopen:remove('search')  -- default: "block,hor,mark,percent,quickfix, search,tag,undo"
	local search = vim.fn.input('Search: ')
	vim.cmd("/"..search)
	-- vim.opt.foldopen:append('search')  -- default: "block,hor,mark,percent,quickfix, search,tag,undo"
end

function vim.getVisualSelection()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg('v')
	vim.fn.setreg('v', {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ''
	end
end

-- Hide status line
-- autocmd! FileType which_key
-- autocmd  FileType which_key set laststatus=0 noshowmode noruler
--			\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

-- Single mappings
wk.register({
	-- ['<leader>S'] = { ':SClose<CR>',                                                 'Startify' },
	['<leader>*'] = { ":lua require'telescope.builtin'.grep_string({path_display = {'shorten'},word_match = '-w', only_sort_text = true, initial_mode = 'normal', })<CR>",       'Find * Project' },
	['<leader>/'] = {":lua require'telescope.builtin'.live_grep{path_display = {'tail'}, word_match = '-w', only_sort_text = true, search = '' }<CR>",                           'Search Project'}     ,
	['<leader>?'] = {':Grepper -cword  -noprompt -tool ag<cr>',                                             'Word to clist (Grepper)'},
	-- ['<leader>?'] = { search_unfolded,                                             'Word to clist (Grepper)'},
	['<leader>p'] = 'which_key_ignore',
	['<leader>R'] = {':Lazy sync<cr>', 'Lazy Sync'},
	['<leader>r'] = {':Telescope frecency<cr>', 'Frecency'},
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

wk.register({
	['<leader>*'] = { function()
		local text = vim.getVisualSelection()
		require"telescope.builtin".live_grep({ default_text = text })
	end,       'Find * Project' },
	['<leader>/'] = { function()
		local text = vim.getVisualSelection()
		require"telescope.builtin".live_grep({ default_text = text })
	end,       'Find / Project' },
	-- ['<leader>/'] = {":lua require'telescope.builtin'.live_grep{path_display = {'tail'}, word_match = '-w', only_sort_text = true, search = '' }<CR>",                           'Search Project'}     ,
}, {mode = "v", prefix = ""})

wk.register({  --ignore magic s and g in cmd mode
	['s/'] = 'which_key_ignore',
	['g/'] = 'which_key_ignore',
}, {mode = "c", prefix = ""})
-- wk.register({
-- 	['<leader>'] = {
-- 		['1-9'] = {
-- 			name = "Jump to Buffer"
-- 		}
-- 	}
-- })
-- wk.register('which_key_ignore'
-- wk.register('which_key_ignore'

-- b for buffers  - for nvim-bufferline<Plug>
-- ['s'] = {':BLines',                              'Search lines fzf'},
local function set_filetype()
	vim.ui.select({ 'python', 'lua', 'text'}, { prompt = 'Select file type:', },
		function(choice)
			vim.bo.filetype = choice -- not working
		end
	)
end
local function pick_filetype()
	vim.ui.select({ 'python', 'lua', 'text'}, { prompt = 'Select file type:', },
		function(choice)
			vim.cmd [[enew]]
			vim.bo.filetype = choice -- not working
		end
	)
end

local showDocumentSymbols = function ()
    local opts= {
        symbols = {
            "class",
            "function",
            -- "method",
        }
    }
    require('telescope.builtin').lsp_document_symbols(opts)
end

local function buffers(opts)
  opts = opts or {}
  opts.previewer = false
  -- opts.sort_lastused = true
  -- opts.show_all_buffers = true
  -- opts.shorten_path = false
  opts.attach_mappings = function(prompt_bufnr, map)
		map("i", "D", require "telescope.actions".delete_buffer)
		return true
  end
	require("telescope.builtin").buffers(require("telescope.themes").get_dropdown(opts))
end

vim.keymap.set("n", "gb", buffers, { noremap = true, silent = true, desc = "Show Buffers List" })


wk.register({
	['<leader>b'] = { name = '+Buffers' },
	-- ['<leader>b/'] = {":lua require('telescope.builtin').current_buffer_fuzzy_find({ sorter = require('telescope.sorters').get_substr_matcher({})})<CR>", 'Search'},
	-- ['<leader>b/'] = {[[:lua require'telescope.builtin'.live_grep({search_dirs = {vim.fn.expand('%')},  default_text = vim.fn.expand('<cword>') })<cr>]], 'Search *'},
	['<leader>b/'] = {[[:lua require'telescope.builtin'.live_grep({search_dirs = {vim.fn.expand('%')}, path_display = {'hidden'} })<cr>]], 'Search /'},
	['<leader>b*'] = {[[:lua require'telescope.builtin'.live_grep({search_dirs = {vim.fn.expand('%')}, path_display = {'hidden'}, default_text = vim.fn.expand('<cword>')})<cr>]], 'Search *'},
	['<leader>b?'] = {[[:lua require'telescope.builtin'.current_buffer_fuzzy_find({path_display = {'hidden'} })<cr>]],                     'Search FZy *'},
	-- ['<leader>b?'] = {':Telescope current_buffer_fuzzy_find<CR>',                                                                                         'Search fuzzy'},
	['<leader>bs'] = {showDocumentSymbols,             'Tele Buffer Symbols'},
	-- ['<leader>bb'] = {buffers,                                                                                                           'Get buffer' } ,
	-- ['<leader>bb'] = { [[:NeoTreeFloat buffers<cr>]],                                                                                                           'Get buffer' } ,
	-- ['<leader>bb'] = {'<c-^>',                                                                                                                            'Cycle with Previous'},
	-- ['<leader>bn'] = {':enew<CR>',                                                                                                                        'New'},
	['<leader>bn'] = { pick_filetype,                                                                                                                        'New'},
	['<leader>b]'] = {':BufferLineCycleNext<CR>',                                                                                                         'Next'},
	['<leader>b['] = {':BufferLineCyclePrev<CR>',                                                                                                         'Previous'},
	-- ['<leader>bc'] = {':confirm bd<CR>',                                                                                                                  'Close'},   -- fixes error on buffer close
	['<leader>bc'] = {':lua MiniBufremove.delete()<CR>',                                                                                                  'Close'},   -- wont change layout From mini plug
	['<leader>bo'] = {':%bd|e#|bd#<CR>',                                                                                                                  'Close all but current'},
	['<leader>bp'] = {':BufferLinePick<CR>',                                                                                                              'Pick (gb)'},
	['<leader>br'] = {':confirm e<CR>',                                                                                                                   'Reload File(e!)'},
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
	-- ['<leader>cF'] = {':Autoformat<CR>',             'Autoformat lines'},
	['<leader>cn'] = {':Neogen<CR>',             'Annotation (Neogen)'},
	['<leader>cc'] = {"<cmd>TextCaseOpenTelescope<CR>",             'Case Change'}, --from text-case.nvim
	['<leader>ca'] = {':lua vim.lsp.buf.code_action()<CR>',                                    'Code Action'} ,
	-- ['<leader>cc'] = {':TSContextToggle<CR>',             'Context toggle'}, --from treesitter-context plug
	-- ['<leader>ca'] = {":lua require('nvim-autopairs').disable()<CR>",             'Auto-pairs disable'}, --from treesitter-context plug
	-- ['<leader>cA'] = {":lua require('nvim-autopairs').enable()<CR>",             'Auto-pairs enable'}, --from treesitter-context plug
	['<leader>cl'] = {":CreateCompletionLine<CR>",             'Create Completion'}, --from treesitter-context plug
	['<leader>co'] = {":AerialNavToggle<cr>",             'Open Outliner (Aerial)'}, --from treesitter-context plug
	-- ['<leader>co'] = {":AerialOpen float<cr>",             'Open Outliner (Aerial)'}, --from treesitter-context plug
	-- ['<leader>co'] = {":AerialOpen float<CR> | :lua require'aerial'.tree_close_all()<cr>",             'Open Outliner (Aerial)'}, --from treesitter-context plug

	['<leader>cs'] = { name = '+Spell' },
	['<leader>css'] = {':setlocal spell! spelllang=en_us<CR>', 'Toggle Spellcheck'},
	['<leader>csa'] = {'zg<CR>', 'Add To Dictionary (zg)'},

	-- ['<leader>cf']= { name = '+Folds'},
	-- ['<leader>cff'] = {':call v:lua.conditional_fold()<CR>', 'Toggle all ON/OFF'},
	-- ['<leader>cfM'] = {'zM<CR>',                             'Close all(zM)'},
	-- ['<leader>cfR'] = {'zR<CR>',                             'Open all (zR)'},
	-- ['<leader>cf+'] = {'zm<CR>',                             'inc+1 (zm)'},
	-- ['<leader>cf-'] = {'zr<CR>',                             'dec-1 (zr)'},
	-- ['<leader>cfa'] = {'za<CR>',                             'Toggle at cur(za)'},
	-- ['<leader>cfA'] = {'zA<CR>',                             'Toggle at cur rec(zA)'},
	-- ['<leader>cfT'] = {'zi<CR>',                             'Toggle fold enable(zi)'},
	-- ['<leader>cfo'] = {'zo<CR>',                             'open cur(zo)'},
	-- ['<leader>cfO'] = {'zO<CR>',                             'open all cur(zO)'},
})

wk.register({
	['<leader>c'] = { name = '+Code'},
	['<leader>cc'] = {"<cmd>TextCaseOpenTelescope<CR>",             'Case Change'}, --from text-case.nvim
	['<leader>ce'] = {":lua require('refactoring').refactor('Extract Function')<CR>",            'Extract Function'},
	['<leader>cv'] = {":lua require('refactoring').refactor('Extract Variable')<CR>",            'Extract Variable'},
	['<leader>ci'] = {":lua require('refactoring').refactor('Inline Variable')<CR>",             'Inline Variable'},
}, {mode = "v", prefix = ""})


wk.register({
	['<leader>d']   = { name = '+Debugger' },
	['<leader>dd']  = { ":lua require'dap'.continue()<cr>",                                             'Continue/Start debugging'} ,
	['<leader>dx']  = { ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>",              'Disconnect'} ,
	['<leader>dX']  = { ":lua require'dap'.close()<CR>",                                                'Close'} ,
	['<leader>dU']  = { ":lua require'dap'.up()<CR>",                                                   'Stack Up'} ,
	['<leader>dD']  = { ":lua require'dap'.down()<CR>",                                                 'Stack Down'} ,
	['<leader>da']  = {
		function()
			-- require'dap'.set_breakpoint() -- moved to dap start handler
			require'dap'.run({type='python', request='attach', host='127.0.0.1', port=5678})
			-- require'hydra'.spawn['dap_hydra']()
		end,    'Attach (localhost, 5678)'} ,
	-- ['<leader>da']  = { ":lua require'dap'.attach('0.0.0.0', 5678)<CR>",                                'Attach (localhost, 5678)'} ,
	['<leader>dl']  = { ":lua require'dap'.run_last()<CR>",                                             'Re-run Last'},
	['<leader>db']  = { ":lua require'dap'.toggle_breakpoint()<CR>",                                    'Toggle breakpoint'},
	-- ['<leader>dc']  = { ":lua require'dap'.goto_()<CR>",                                             'Run to Cursor'},
	['<leader>du']  = { ":lua require('dapui').setup()<CR>",                                            'UI Start'} ,
	['<leader>dC']  = { ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>",             'UI Close'},
	['<leader>dbc'] = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", 'Conditional breakpoint'},
	['<leader>dk']  = { ":lua require('dap.ui.widgets').hover()<CR>",                                   'Eval popup'},
	['<leader>dK']  = { ":lua require('dapui').eval(nil, {enter=true})<CR>",                             'Eval window'}, -- call 2x to jump to window
	['<leader>dn']  = { ":lua require'dap'.step_over()<CR>",                                            'Step Over'},
	['<leader>dc']  = { ":lua require'dap'.run_to_cursor()<CR>",                                        'Run to Cursor'},
	['<leader>dr']  = { ":lua require'dap'.repl.toggle()<CR>",                                          'Repl Toggle'},
	['<leader>dL']  = { ":lua require'osv'.launch()<cr>",                                          'Start Lua Dap Server'},
})

function _G.yankpath()
	vim.cmd([[let @+=expand('%:p')]])
end
-- file
wk.register({
	['<leader>f'] = { name = '+File' },
	['<leader>fs'] = { ':update<CR>',                                      'Save'},
	['<leader>fS'] = { ':call v:lua.CmdInput("w %s")<CR>',                 'Save as'},
	['<leader>fe'] = { ':luafile%<CR>',                                    'Source %'},
	['<leader>fd'] = { ':call delete(expand("%")) | bdelete!<CR>',         'Delete!'},
	['<leader>fr'] = {':confirm e<CR>',                                    'Reload File(e!)'},
	-- ['<leader>ff'] = {':Telescope file_browser<CR>',                       'File Browser (fuzzy)'},
	['<leader>fy'] = { ":call v:lua.yankpath()<CR>",                       'Yank file location<CR>'},
	['<leader>fo'] = { ':!xdg-open "%:p:h"<CR>',                           'Open containing folder'},
	-- ['<leader>ft'] = { set_filetype,                                                                                                                        'Set Filetype'},
	['<leader>ft'] = {':Telescope filetypes<CR>',    'filetypes'},

	['<leader>fc'] = {':cd %:p:h<CR>',                                     'cd %'},
})

local function diffWithSaved()
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	vim.cmd.diffthis()
	vim.cmd[[vnew | r # | normal! 1Gdd]]
	vim.cmd.diffthis()
	vim.cmd.execute([["setlocal bt=nofile bh=wipe nobl noswf ro"]])
    vim.bo.filetype = buf_ft
end

local function compare_to_clipboard()
	local ftype = vim.api.nvim_eval("&filetype")
	vim.cmd.vsplit()
	vim.cmd.enew()
	vim.cmd [[ normal! P ]]
    -- local bufnr = vim.api.nvim_get_current_buf()
    -- vim.api.nvim_set_option_value('modifiable', false, {}) # fucks things up
    vim.cmd.diffthis() -- put new buff in diff mode
    vim.cmd.file('ClipBoard')
    vim.api.nvim_set_option_value('filetype', ftype, {})
	vim.cmd.wincmd('p')
    vim.cmd.diffthis() -- put original buff in diff mode
end

-- g is for git
wk.register({
	['<leader>g'] = { name = '+GIT' },
	['<leader>gg'] = {':FloatermNew lazygit<CR>'             , 'LazyGit'},  -- defined in  nvim-toggleterm.lua plug
	['<leader>g['] =  { '[c<CR>',                                   'Prev change [c'},
	['<leader>g]'] =  { ']c<CR>',                                   'Next change ]c'},
	['<leader>go'] =  { ':diffget<CR>',                             'Obtain(do)'},
	['<leader>gp'] =  { ':diffput<CR>',                             'Put(dp)'},
	['<leader>gt'] =  { ':diffthis<CR>',                            'Diff This'},
	['<leader>gu'] =  { ':diffupdate<CR>',                          'Update changes'},
	['<leader>gw'] =  { ':windo diffthis<cr>',                      'Diff visible windows'},
    ['<leader>gc'] = {  compare_to_clipboard,                       'Diff with clipboard'},   -- fixes error on buffer close
    ['<leader>gs'] = {  diffWithSaved,                              'Diff with saved'},   -- fixes error on buffer close


    ['<leader>gn'] = { name = '+Neogit' },
	['<leader>gfn'] = {':Neogit<CR>'                            , 'git grep'},
	['<leader>gfc'] = {':Neogit commit<CR>'                       , 'commit'},

	['<leader>gd'] = { name = '+DiffView' },
	['<leader>gdd'] =  { ':DiffviewOpen<CR>',                        'Diffview Open'},
	['<leader>gdh'] =  { ':DiffviewFileHistory --base=LOCAL %<CR>',  'Diffview File History (LOCAL)'},
	['<leader>gdf'] =  { ':DiffviewFileHistory %<CR>',               'Diffview File History'},

})
-- ['h'] - taken by git_sign - hunk oper
-- ['A'] = {':Git add %'                        , 'add current'},
-- ['S'] = {':!git status'                      , 'status'},


wk.register({
	['<leader>h'] = { name = '+History' },
	['<leader>hu'] = {':UndotreeToggle<CR>',            'Undo Tree'} ,
	['<leader>hw'] = {':call v:lua.CmdInput("LHWrite %s")<CR>', 'Local History Write'},
	['<leader>hl'] = {':LHLoad<CR>',                    'Local History Load'},
	['<leader>hb'] = {':LHBrowse<CR>',                  'Local History Browse'},
	['<leader>hx'] = {':LHDelete<CR>',                  'Local History Delete'},
	['<leader>hd'] = {':LHDiff<CR>',                    'Local History Diff'},
	['<leader>hD'] = {':DiffSaved<CR>',                 'Diff with saved'},
	['<leader>hh'] = {':Gclog<CR>',                     'File rev history'},
})

wk.register({
	['<leader>j'] = { name = '+Jump' },
	['<leader>ju'] = {':lua require("tsht").move({ side = "start" })<cr>',   'Jump Node'} , -- (nvim-treehopper' })
	['<leader>jl'] = {':HopLineStart<cr>',                                   'HopLineStart'},
	['<leader>jc'] = {':HopChar1<cr>',                    'HopChar1'},
	['<leader>jw'] = {':HopWord<cr>',                    'HopWord'},
})

wk.register({
	['<leader>l'] = { name = '+LSP' },
	['<leader>lD'] = {':lua vim.lsp.buf.declaration()<CR>',                                    'Declaration (gD)'},
	-- ['<leader>ld'] = {':lua vim.lsp.buf.definition()<CR>',                                     'Definition (gd)'},
	['<leader>ld'] = {'<cmd>lua vim.diagnostic.setloclist()<CR>', 'Diagnostics to LocList'} ,
	['<leader>lK'] = {':lua vim.lsp.buf.hover()<CR>',                                          'Hover (K)'},
	['<leader>li'] = {':lua vim.lsp.buf.implementation()<CR>',                                 'Implementation (gi)'},
	['<leader>lh'] = {':lua vim.lsp.buf.signature_help()<CR>',                                 'Signature Help'},
	['<leader>ls'] = {':lua vim.lsp.buf.rename()<CR>',                                         'Rename'}  ,
	['<leader>lr'] = {':lua vim.lsp.buf.references()<CR>',                                     'References (gr)'} ,
	['<leader>lf'] = {':lua vim.lsp.buf.format()<CR>',                                     'Formatting'} ,
	['<leader>la'] = {':lua vim.lsp.buf.code_action()<CR>',                                    'Code Action'} ,
	['<leader>lA'] = {':lua vim.lsp.buf.add_workspace_folder()<CR>',                           'Add Workspace Folder'} ,
	['<leader>lR'] = {':lua vim.lsp.buf.remove_workspace_folder()<CR>',                        'Remove Workspace Folder'} ,
	['<leader>lL'] = {':lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR><CR>', 'List Workspace Folders'} ,
	['<leader>lt'] = {':LspTroubleToggle<CR>',                                                 'Lsp Trouble Toggle'},


	['<leader>lT'] = { name = '+Telescope' },
	['<leader>lTr'] = {':Telescope lsp_references<CR>',           'References'},
	['<leader>lTd'] = {':Telescope lsp_definitions<CR>',          'Definitions'},
	['<leader>lTa'] = {':Telescope lsp_code_actions<CR>',         'Code Actions'},
	['<leader>lTA'] = {':Telescope lsp_range_code_actions<CR>',   'Range Code Actions'},
	['<leader>lTs'] = {':Telescope lsp_document_symbols<CR>',     'Document Symbols'},

	['<leader>lTS'] = {':Telescope lsp_workspace_symbols<CR>',    'Workspace Symbols'},
	['<leader>lTD'] = {':Telescope lsp_document_diagnostics<CR>', 'Document Diagnostics'},
})


wk.register({
	['<leader>L'] = { name = '+LLAMA' },
	['<leader>LL'] = {':Gen<CR>',                                    'LLama'},
	-- ['<leader>LD'] = {':LlmDelete<CR>',                                    'Delete last Ouput'},
	-- ['<leader>LC'] = {':LlmCancel<CR>',                                    'Cancell last Ouput'},
})

wk.register({
	['<leader>L'] = { name = '+LLAMA' },
	-- ['<leader>LL'] = {':Llm modify<CR>',                                    'Modify Selection'},
	['<leader>LL'] = { ':Gen<cr>',                                    'LLama'},
}, {mode = "v", prefix = ""})


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
		vim.cmd(':set winwidth=90')
	end
end
-- below is required or else which key wont work !!
-- vim.api.nvim_set_keymap( "n", "<Leader>ww",  'v=lua.conditional_width()',  {expr = true, noremap = true, silent = true } )


wk.register({
	['<leader>o'] = { name = '+Open' },
	['<leader>o/'] = {'q/',                                          'Search History (q/)'},
	-- ['<leader>o.'] = {':Fern . -reveal=%<CR>',                    'File Browse (Fern)'},
	-- ['<leader>of'] = {":lua require('telescope').extensions.file_browser.file_browser({initial_mode = 'normal'})<CR><ESC>",            'File Browser (fuzzy)'},
	['<leader>od'] = {':Dirbuf<CR>',                                 'Dirbuf'},
	['<leader>oE'] = {':Ex<CR>',                                     'Open Explorer(Ex)'} ,
	['<leader>oU'] = {':UndotreeToggle<CR>',                         'Undo Tree'} ,
	['<leader>oh'] = {'q:',                                          'Commands History (q:)'},
	['<leader>oq'] = {':copen<CR>',                                  'Quickfix (copen)'},
	['<leader>oo'] = {':lopen<CR>',                                  'Loclist (lopen)'},
	['<leader>oO'] = {':SymbolsOutline<CR>',                         'Outliner (lsp)'},
	['<leader>ol'] = {':Luapad<CR>',                                 'Luapad Repl On'},
	['<leader>oL'] = {":lua.require('luapad').detach()<CR>",         'Luapad Repl Off'},
	['<leader>oa'] = {":AerialOpen float<cr>",                       'Open Outliner (Aerial)'}, --from treesitter-context plug
	-- ['<leader>oc'] = {':Codi<CR>',                                   'Codi Start (multi lang REPL)'},
	['<leader>oc']  = {
		function()
            vim.cmd[[Codi]]
			require'hydra'.spawn['codi']()
		end, 'Codi Start (multi lang REPL)'},
	['<leader>oC'] = {':Codi!<CR>',                                  'Codi Stop'},
	['<leader>ot'] = {':FloatermNew<CR>',                                  'Term Float'},
	['<leader>oT'] = { ':!alacritty --working-directory "%:p:h"<CR>',      'Terminal External'},

})

-- function _G.replace_word()
--	local name = vim.fn.input('To: ')
--	vim.cmd(":.,$s/\\<"..vim.fn.expand('<cword>').."\\>/"..name.."/gc|1,''-&&") -- substitute and ask each time
-- end
wk.register({
	['<leader>s'] =   { name = '+Substitute' },
	['<leader>sp'] =  { name = '+Project' },
	['<leader>spf'] = {':Farr<CR>',                                 'File Farr'},
	['<leader>spe'] = {'<plug>(operator-esearch-prefill)<CR>',      'Esearch'},   -- seems to be maintained
	['<leader>spc'] = {'<Plug>CtrlSFPrompt -R {regex} -G *.py',     'CtrlSF'},
	['<leader>sp*'] = {'<Plug>CtrlSFCCwordPath<CR>',                'CtrlSF Word'},
	['<leader>sps'] = {":lua require('spectre').open()<CR>",        'Spectre'},
	-- ['<leader>r*'] = {":let @/=expand('<cword>')<cr>cgn",        'Replace word with yank'},
	-- ['<leader>s*'] = {":.,$s/\\<<C-r><C-w>\\>/<C-r>+/gc|1,''-&&<CR>",  'Replace word with yank', mode='n'},       -- \<word\>  -adds whitespace  word limit (sub only whole words)
	['<leader>s/'] = {
	function()
		local name = vim.fn.input('To: ', vim.fn.expand('<cword>'))
		vim.cmd(":.,$s/\\<"..vim.fn.expand('<cword>').."\\>/"..name.."/gc|1,''-&&")
	end,                                                                                  'Replace word'},       -- write to reg z (@a) then use it for replacign * word
	['<leader>ss'] = {":lua require('spectre').open_file_search({select_word=true})<CR>",        'Spectre Local'},
	-- ['<leader>s/'] = {":lua require('searchbox').replace({default_value = vim.fn.expand('<cword>'), confirm = 'menu'})<CR>", 'Find and Replace word'},       -- write to reg z (@a) then use it for replacign * word
	-- ['<leader>s*'] = {[["ayiw:lua require('searchbox').replace({confirm='menu'})<CR><C-r>=getreg('a')<CR><CR>:sl m<CR><C-r>=getreg('"')<CR>]], 'Replace word'},       -- write to reg z (@a) then use it for replacign * word
})
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

wk.register({  -- second one for visual mode
	['<leader>sp'] = { name = '+Project'},
	['<leader>spc'] = {'<Plug>CtrlSFPrompt -R {regex} -G *.py',     'CtrlSF'},
	['<leader>sp*'] = {'<Plug>CtrlSFVwordPath<CR>',                 'CtrlSF Word'},
	['<leader>sp/'] = {"\"ay:lua require('spectre').open()<cr>\"aPa",        'Spectre'},
}, {mode = "v", prefix = ""})

wk.register({  -- second one for visual mode
	['<leader>s'] = { name = '+Substitute'},
	['<leader>s*'] = {"\"ay:.,$s/<C-r>a/<C-r>+/gc|1,''-&&<CR>",					 'Replace word with yank'},    -- \<word\>  -adds whitespace  word limit (sub only whole words)
	['<leader>ss'] = {":lua require('spectre').open_file_search()<CR>",        'Spectre Local'},
	['<leader>s/'] = {
	function()
		vim.cmd("normal! \"ay")
		local name = vim.fn.input('To: ', vim.fn.getreg('a'))
		vim.cmd(":.,$s/"..vim.fn.getreg('a').."/"..name.."/gc|1,''-&&")
	end ,		                                                            			 'Replace word'},    -- \<word\>  -adds whitespace  word limit (sub only whole words)
}, {mode = "v", prefix = ""})

-- MiniSessions.write(nil, {force = true})
-- function to save current session, close all buffers and open MiniStarter.open() - startup screen

function Save_current_session()
		if vim.v.this_session ~= '' then
			MiniSessions.write(nil, {force = true})
			print('Saved Session')
		end
end

local function StarterOpen()
		Save_current_session()
		local buffers = vim.api.nvim_list_bufs()
		for _, buffer in ipairs(buffers) do
				vim.api.nvim_buf_delete(buffer,{force = true})
		end
		MiniStarter.open()
		vim.fn.feedkeys(t('<CR>'))
end

wk.register({
	['<leader>S'] = { name = '+Session' },
	['<leader>SS'] = { StarterOpen,                                                 'MiniStarter' },
	-- ['<leader>P*'] = {":lua require'telescope.builtin'.grep_string{path_display = {'shorten'},word_match = '-w', only_sort_text = true, initial_mode = 'normal', }<CR>", 'Find Word'}    ,
	-- ['<leader>P/'] = {':Grepper-cword<CR>',                                             'Word to clist (Grepper)'},
	['<leader>Ss'] = { Save_current_session,                                                'Save Current'}  ,
	['<leader>Sa'] = {':call v:lua.CmdInput("lua MiniSessions.write(\'%s\')")<CR>',          'Save as'}  ,
	['<leader>Sc'] = {':SClose<CR>',                                                    'Sesion Close'} ,
	['<leader>Sd'] = {':SDelete<CR>',                                                   'Sesion Delete'},
	['<leader>So'] = {':so /home/bartosz/.config/nvim/lua/settings.lua<CR>',            'Source Defaults'},
	-- Startify
	-- ['<leader>Ps'] = {':SSave<CR>',                                                     'Sesion Save'}  ,
	-- ['<leader>Pl'] = {':SLoad<CR>',                                                     'Sesion Load'}  ,
	-- ['<leader>Pc'] = {':SClose<CR>',                                                    'Sesion Close'} ,
	-- ['<leader>Pd'] = {':SDelete<CR>',                                                   'Sesion Delete'},
	-- ['<leader>Pf'] = {':Telescope live_grep<CR>',                                       'Find (live grep)'}     ,
	-- ['<leader>Pz'] = {":lua require'telescope.builtin'.grep_string{path_display = {'tail'}, word_match = '-w', only_sort_text = true, search = '' }<CR>", 'Find fuzzy'},
})



wk.register({
	['<leader>t'] = { name = '+Telescope' },
	['<leader>tt'] = {':Telescope<CR>'                     , 'Telescope'},
	['<leader>tb'] = {':Telescope buffers<CR>'             , 'Buffers'},
	['<leader>to'] = {':Telescope oldfiles<CR>'            , 'Oldfiles'},
	['<leader>tc'] = {':Telescope colorscheme<CR>'         , 'colorscheme'},
    ['<leader>ts'] = {showDocumentSymbols                  , 'Buffer Symbols'},
	['<leader>th'] = {':Telescope help_tags<CR>'           , 'Help'},
})


wk.register({
	['<leader>u'] = { name = '+UI' },
	['<leader>ua'] = {':call v:lua.conditional_width()<CR>', 'Auto width'},
	['<leader>uw'] = {':set wrap!<CR>'                     , 'Toggle Wrap'},
	['<leader>ul'] = {':set list!<CR>'                     , 'Toggle List Chars'},
	['<leader>uc'] = {':Telescope colorscheme<CR>'         , 'Colorscheme'},
	['<leader>uh'] = {':set hlsearch!<CR>'                 , 'Search highlight'},
	['<leader>uf'] = {':FocusToggle<cr>'                   , 'Focus Toggle'},
	['<leader>ut'] = {':Twilight<cr>'                      , 'Twilight'},
})


-- n is for Window
wk.register({
	['<leader>w'] = { name = '+Window' },
	['<leader>w='] = {'<C-w>=<CR>',                                     'Equalize(=)'},
	['<leader>w>'] = {':vertical resize +25<CR>',                       'Increase(>)'},
	['<leader>w<lt>'] = {':vertical resize -25<CR>',                    'Decrease(<)'},
	['<leader>wh'] = {'<C-w>s<CR>',                                     'Split below(s)'},
	['<leader>wv'] = {'<C-w>v<CR>',                                     'Split right(v)'},
	['<leader>wq'] = {'<C-w>q<CR>',                                     'Quit window(q)'},
	['<leader>wO'] = {':only<CR>',                                      'Close All other splits(o)'},
	['<leader>wo'] = {'<C-w>o<CR>',                                     'Close All but current(o)'},
	['<leader>ww'] = {':call v:lua.CmdInput(":set winwidth=")<CR>',     'Set width'},
	-- ['<leader>wm'] = {':call v:lua.CmdInput(":set winminwidth=")<CR>',  'Set min width'},
	-- ['<leader>wm'] = {':WindowsMaximize<CR>',  'Maximize'},  -- anuvyklack/windows.nvim  plug
	['<leader>wa'] = {':call v:lua.conditional_width()<CR>',            'Auto width'},
})



-- TSContextDisable - if srm treesitter-context
wk.register({
	['<leader>q'] = { name = '+Quit' }       ,
	['<leader>qf'] = {':q!<CR>'                , 'Force Quit (q!)'}      ,
	['<leader>qs'] = {':bufdo update | q!<CR>' , 'Quit Save all (wqa!)'} ,
	['<leader>qq'] = {':TSContextDisable<cr>|:call v:lua.Save_current_session()<CR>|:confirm qa',        'Quit Confirm (qa)'},
})
wk.register({  -- second one for visual mode
	['<leader>q'] = { name = '+Quit'},
	['<leader>qq'] = {':<ESC>|:TSContextDisable<cr>|:call v:lua.Save_current_session()<CR>|:confirm qa<cr>',        'Quit Confirm (qa)'},
}, {mode = "v", prefix = ""})



wk.register({
  O = {
    name = "Ollama GPT",
      e = { "<cmd>OGPTRun edit_with_instructions<CR>", "Edit with instruction", mode = { "n", "v" } },
      c = { "<cmd>OGPTRun edit_code_with_instructions<CR>", "Edit code with instruction", mode = { "n", "v" } },
      g = { "<cmd>OGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
      t = { "<cmd>OGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
      k = { "<cmd>OGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
      d = { "<cmd>OGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
      a = { "<cmd>OGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
      o = { "<cmd>OGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
      s = { "<cmd>OGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
      f = { "<cmd>OGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
      x = { "<cmd>OGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
      r = { "<cmd>OGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
      l = { "<cmd>OGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
    },
}, { prefix = "<leader>" })


-- TEMP fix for https://github.com/folke/which-key.nvim/issues/273  -- window closed immediately error when using Telescope
local show = wk.show
wk.show = function(keys, opts)
		if vim.bo.filetype == "TelescopePrompt" then
				local map = "<c-r>"
				local key = vim.api.nvim_replace_termcodes(map, true, false, true)
				vim.api.nvim_feedkeys(key, "i", true)
		end
		show(keys, opts)
end-- Register which key map




