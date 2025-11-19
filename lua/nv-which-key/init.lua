vim.g.mapleader = " "
vim.g.maplocalleader = ","
require("which-key").setup {
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
}
local wk = require "which-key"
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
  local name = vim.fn.input "Name: "
  -- eg: cmd =  string.format('Script Name: "%s"', name)
  local full_cmd = string.format(cmd, name)
  print(full_cmd)
  vim.cmd(full_cmd)
end

local function search_unfolded()
  -- skip folded lines (wont work with nN remaps and hlslens)
  vim.opt.foldopen:remove "search" -- default: "block,hor,mark,percent,quickfix, search,tag,undo"
  local search = vim.fn.input "Search: "
  vim.cmd("/" .. search)
  -- vim.opt.foldopen:append('search')  -- default: "block,hor,mark,percent,quickfix, search,tag,undo"
end

function vim.getVisualSelection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

-- Hide status line
-- autocmd! FileType which_key
-- autocmd  FileType which_key set laststatus=0 noshowmode noruler
--			\| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

-- Single mappings
wk.add {
  { "<leader>*", ":lua require'telescope.builtin'.grep_string({path_display = {'shorten'},word_match = '-w', only_sort_text = true, initial_mode = 'normal', })<CR>", desc = "Find * Project" },
  { "<leader>/", ":lua require'telescope.builtin'.live_grep{path_display = {'tail'}, word_match = '-w', only_sort_text = true, search = '' }<CR>", desc = "Search Project" },
  { "<leader>1", hidden = true },
  { "<leader>2", hidden = true },
  { "<leader>3", hidden = true },
  { "<leader>4", hidden = true },
  { "<leader>5", hidden = true },
  { "<leader>6", hidden = true },
  { "<leader>7", hidden = true },
  { "<leader>8", hidden = true },
  { "<leader>9", hidden = true },
  { "<leader>?", ":lua require('grug-far').grug_far({ engine='rg' ,prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "Find CWord" },
  { "<leader>R", ":Lazy sync<cr>", desc = "Lazy Sync" },
  { "<leader>p", hidden = true },
  { "<leader>r", ":Telescope find_files<cr>", desc = "Files" },
}

wk.add {
  {
    "<leader>*",
    function()
      local text = vim.getVisualSelection()
      require("telescope.builtin").live_grep { default_text = text }
    end,
    desc = "Find * Project",
    mode = "v",
  },
  {
    "<leader>/",
    function()
      local text = vim.getVisualSelection()
      require("telescope.builtin").live_grep { default_text = text }
    end,
    desc = "Find / Project",
    mode = "v",
  },
  -- ['<leader>/'] = {":lua require'telescope.builtin'.live_grep{path_display = {'tail'}, word_match = '-w', only_sort_text = true, search = '' }<CR>",                           'Search Project'}     ,
}

wk.add { --ignore magic s and g in cmd mode
  { "g/", hidden = true, mode = "c" },
  { "s/", hidden = true, mode = "c" },
}
-- wk.register({
-- 	['<leader>'] = {
-- 		['1-9'] = {
-- 			name = "Jump to Buffer"
-- 		}
-- 	}
-- })
-- wk.register('which_key_ignore'
-- wk.register('which_key_ignore'

local function pick_filetype()
  vim.ui.select({ "python", "lua", "text" }, { prompt = "Select file type:" }, function(choice)
    vim.cmd [[enew]]
    vim.bo.filetype = choice -- not working
  end)
end

local showDocumentSymbols = function()
  local opts = {
    symbols = {
      "class",
      "function",
      -- "method",
    },
  }
  require("telescope.builtin").lsp_document_symbols(opts)
end

local function buffers(opts)
  opts = opts or {}
  opts.previewer = false
  -- opts.sort_lastused = true
  -- opts.show_all_buffers = true
  -- opts.shorten_path = false
  opts.attach_mappings = function(prompt_bufnr, map)
    map("i", "D", require("telescope.actions").delete_buffer)
    return true
  end
  require("telescope.builtin").buffers(require("telescope.themes").get_dropdown(opts))
end

vim.keymap.set("n", "gb", buffers, { noremap = true, silent = true, desc = "Show Buffers List" })

wk.add {
  { "<leader>b", group = "Buffers" },
  -- ['<leader>b/'] = {":lua require('telescope.builtin').current_buffer_fuzzy_find({ sorter = require('telescope.sorters').get_substr_matcher({})})<CR>", 'Search'},
  -- ['<leader>b/'] = {[[:lua require'telescope.builtin'.live_grep({search_dirs = {vim.fn.expand('%')},  default_text = vim.fn.expand('<cword>') })<cr>]], 'Search *'},
  { "<leader>b*", ":lua require'telescope.builtin'.live_grep({search_dirs = {vim.fn.expand('%')}, path_display = {'hidden'}, default_text = vim.fn.expand('<cword>')})<cr>", desc = "Search *" },
  { "<leader>b/", ":lua require'telescope.builtin'.live_grep({search_dirs = {vim.fn.expand('%')}, path_display = {'hidden'} })<cr>", desc = "Search /" },
  { "<leader>b?", ":lua require'telescope.builtin'.current_buffer_fuzzy_find({path_display = {'hidden'} })<cr>", desc = "Search FZy *" },
  { "<leader>bc", ":lua MiniBufremove.delete()<CR>", desc = "Close" },
  { "<leader>bn", pick_filetype, desc = "New" },
  { "<leader>bo", ":%bd|e#|bd#<CR>", desc = "Close all but current" },
  { "<leader>br", ":confirm e<CR>", desc = "Reload File(e!)" },
  { "<leader>bs", showDocumentSymbols, desc = "Tele Buffer Symbols" },
}

wk.add {
  { "<leader>b", group = "Buffers", mode = "v" },
  { "<leader>b*", "\"ay:lua require'telescope.builtin'.live_grep({search_dirs = {vim.fn.expand('%')}, path_display = {'hidden'}, default_text = vim.fn.getreg('a')})<cr>", desc = "Search *", mode = "v" },
}
-- ['c']= {
--		name= '+Changes',
--		['t'] = {':TCV',   'Toggle line changes'},
--		['D'] = {':DC',    'Disable line changes'},
--		['E'] = {':EC',    'Enable line changes'},
--		['s'] = {':CT',    'Style mode'},
--		['d'] = {':CD',    'Local Changes Diff'},
--		['f'] = {':CF',    'Fold non-changed lines'},
--		},

wk.add {

  { "<leader>c", group = "Code" },
  -- ['<leader>co'] = {":AerialOpen float<cr>",             'Open Outliner (Aerial)'}, --from treesitter-context plug
  -- ['<leader>co'] = {":AerialOpen float<CR> | :lua require'aerial'.tree_close_all()<cr>",             'Open Outliner (Aerial)'}, --from treesitter-context plug
  -- ['<leader>cc'] = {':TSContextToggle<CR>',             'Context toggle'}, --from treesitter-context plug
  { "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
  { "<leader>cc", "<cmd>TextCaseOpenTelescope<CR>", desc = "Case Change" },
  {
    "<leader>cd",
    function()
      vim.diagnostic.open_float()
      -- vim.diagnostic.config { virtual_lines = { current_line = true } }
      -- local show_diag = vim.diagnostic.config().virtual_lines
      -- if show_diag then
      --   vim.diagnostic.config { virtual_lines = false }
      -- else
      -- end
    end,
    desc = "Diagnostic Float",
  },

  { "<leader>cl", ":CreateCompletionLine<CR>", desc = "Create Completion" },
  { "<leader>co", ":AerialNavToggle<cr>", desc = "Open Outliner (Aerial)" },
}

wk.add {
  mode = { "v" },
  { "<leader>c", group = "Code" },
  { "<leader>cc", "<cmd>TextCaseOpenTelescope<CR>", desc = "Case Change" },
  { "<leader>ce", ":Refactor extract<CR>", desc = "Extract Function" },
  { "<leader>ci", ":Refactor inline_var<CR>", desc = "Inline Variable" },
  { "<leader>cv", ":Refactor extract_var<CR>", desc = "Extract Variable" },
}

-- copilot section using capital C: CopilotChatOpen, CopilotChatClose, CopilotChatExplain, CopilotChatFix,  CopilotChatOptimize, CopilotChatDocs
wk.add({
  mode = { "v" },
  { "<leader>C", group = "Copilot" },
  { "<leader>Ca", function() local input = vim.fn.input("Quick Chat: ") if input ~= "" then require("CopilotChat").ask(input, { selection = require("CopilotChat.select").selection }) end end, desc = "CopilotChat - Quick chat", },
  { "<leader>CC", ":CopilotChatOpen<CR>", desc = "Open Chat" },
  { "<leader>Cd", ":CopilotChatDocs<CR>", desc = "Docs" },
  { "<leader>Ce", ":CopilotChatExplain<CR>", desc = "Explain" },
  { "<leader>Cf", ":CopilotChatFix<CR>", desc = "Fix" },
  { "<leader>Co", ":CopilotChatOptimize<CR>", desc = "Optimize" },
  { "<leader>Cx", ":CopilotChatClose<CR>", desc = "Close Chat" },
}, { mode = "v", prefix = "" })

wk.add {
  { "<leader>d", group = "Debugger" },
  { "<leader>dC", ":lua require('dapui').close()<cr>:DapVirtualTextForceRefresh<CR>", desc = "UI Close" },
  { "<leader>dD", ":lua require'dap'.down()<CR>", desc = "Stack Down" },
  { "<leader>dK", ":lua require('dapui').eval(nil, {enter=true})<CR>", desc = "Eval window" },
  { "<leader>dL", ":lua require'osv'.launch({port=5678})<cr>", desc = "Start Lua Dap Server (port 5678)" },
  { "<leader>dU", ":lua require'dap'.up()<CR>", desc = "Stack Up" },
  { "<leader>dX", ":lua require'dap'.close()<CR>", desc = "Close" },
  {
    "<leader>da",
    function()
      -- require'dap'.set_breakpoint() -- moved to dap start handler
      require("dap").run { type = "python", request = "attach", host = "127.0.0.1", port = 5678, name="Attach to localhost:5678" }
      -- require'hydra'.spawn['dap_hydra']()
    end,
    desc = "Attach (localhost, 5678)",
  },
  { "<leader>db", ":lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle breakpoint" },
  { "<leader>dbc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Conditional breakpoint" },
  { "<leader>dc", ":lua require'dap'.run_to_cursor()<CR>", desc = "Run to Cursor" },
  { "<leader>dd", ":lua require'dap'.continue()<cr>", desc = "Continue/Start debugging" },
  {
    "<leader>dh",
    function()
      require("hydra").spawn["dap_hydra"]()
    end,
    desc = "Dap Hydra",
  },
  { "<leader>dk", ":lua require('dap.ui.widgets').hover()<CR>", desc = "Eval popup" },
  { "<leader>dl", ":lua require'dap'.run_last()<CR>", desc = "Re-run Last" },
  { "<leader>dn", ":lua require'dap'.step_over()<CR>", desc = "Step Over" },
  { "<leader>dr", ":lua require'dap'.repl.toggle()<CR>", desc = "Repl Toggle" },
  { "<leader>du", ":lua require('dapui').setup()<CR>", desc = "UI Start" },
  { "<leader>dx", ":lua require'dap'.disconnect({ terminateDebuggee = false })<CR>", desc = "Disconnect" },
}

function _G.yankpath()
  vim.cmd [[let @+=expand('%:p')]]
end



local set_root = function()
  -- Array of file names indicating root directory. Modify to your liking.
  local root_names = { ".git", "Makefile" }
  local break_on_dirs = {'addons', '.config', 'bartosz'}

  -- Cache to use for speed up (at cost of possibly outdated results)
  local root_cache = {}

  -- Get directory path to start search from
  local path = vim.api.nvim_buf_get_name(0)
  if path == "" then
    return
  end
  path = vim.fs.dirname(path)

  -- Try cache and resort to searching upward for root directory
  print("Searching for root directory...")
  print("Starting from: " .. path)
  local root = root_cache[path]
  if root == nil then
    local current = path
    local root_file = vim.fs.find(root_names, { path = current, upward = true })[1]
    if root_file ~= nil then
      print("Root found: " .. root_file)
      root = vim.fs.dirname(root_file)
      root_cache[path] = root
    end
  end

  -- If root found, ask user for confirmation
  if root and vim.fn.isdirectory(root) == 1 then
    local confirm = vim.fn.confirm(
      "Change directory to: " .. root,
      "&Yes\n&No",
      1
    )
    if confirm == 1 then
      vim.cmd.cd(root)
      print("Changed directory to: " .. root)
    end
  else
    print("No root directory found")
  end
end

-- file
wk.add {
  { "<leader>f", group = "File" },
  { "<leader>fS", ':call v:lua.CmdInput("w %s")<CR>', desc = "Save as" },
  { "<leader>fc", ":cd %:p:h<CR>", desc = "cd %" },
  { "<leader>ffr", function() set_root() end, desc = 'Search up for root dir'} ,
  -- { "<leader>fd", ':call delete(expand("%")) | bdelete!<CR>', desc = "Delete!" },
  { "<leader>fd", function()
      -- Prompt for confirmation before deleting the file
      local filename = vim.fn.expand("%:t")
      local response = vim.fn.confirm("Are you sure you want to delete '" .. filename .. "'?", "&Yes\n&No", 2)

      if response == 1 then
          -- User confirmed deletion
          vim.fn.delete(vim.fn.expand("%"))
          vim.cmd('bdelete!')
      end
  end, desc = "Delete file" },
  { "<leader>fe", ":luafile%<CR>", desc = "Source %" },
  { "<leader>fo", ':!xdg-open "%:p:h" &<CR>', desc = "Open containing folder" }, -- & - prevents blocking nvim ui
  { "<leader>fr", ":confirm e<CR>", desc = "Reload File(e!)" },
  { "<leader>fs", ":update<CR>", desc = "Save" },
  { "<leader>ft", ":Telescope filetypes<CR>", desc = "filetypes" },
  { "<leader>fy", ":call v:lua.yankpath()<CR>", desc = "Yank file location<CR>" },
}

local function diffWithSaved()
  local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  vim.cmd.diffthis()
  vim.cmd [[vnew | r # | normal! 1Gdd]]
  vim.cmd.diffthis()
  vim.cmd.execute [["setlocal bt=nofile bh=wipe nobl noswf ro"]]
  vim.bo.filetype = buf_ft
end

local function compare_to_clipboard()
  local ftype = vim.api.nvim_eval "&filetype"
  vim.cmd.vsplit()
  -- check if 'Clipboard' buffer exists if not create it, else use it
  local bufnr = vim.fn.bufnr "ClipBoard"
  if bufnr == -1 then
    vim.cmd.enew()
    vim.cmd [[ normal! P ]]
    vim.cmd.file "ClipBoard"
  else -- set current buffer to 'ClipBoard' and paste
    vim.cmd.edit "ClipBoard"
    vim.cmd [[ normal! ggVG"_dP ]]
  end
  --    -- local bufnr = vim.api.nvim_get_current_buf()
  --    -- vim.api.nvim_set_option_value('modifiable', false, {}) # fucks things up
  vim.cmd.diffthis() -- put new buff in diff mode
  vim.api.nvim_set_option_value("filetype", ftype, {})
  vim.cmd.wincmd "p"
  vim.cmd.diffthis() -- put original buff in diff mode
end

 -- Compare clipboard to visual selection
local function compare_clipboard_selection()
  local ftype = vim.api.nvim_eval("&filetype")
  vim.cmd(string.format([[
    execute "normal! \"xy"
    vsplit
    enew
    normal! P
    setlocal buftype=nowrite
    set filetype=%s
    diffthis
    execute "normal! \<C-w>\<C-w>"
    enew
    set filetype=%s
    normal! "xP
    diffthis
  ]], ftype, ftype))
end
-- Function to toggle 'iwhite' in 'diffopt'
local function toggle_iwhite()
  local diffopt = vim.api.nvim_get_option('diffopt')
  if diffopt:find('iwhite') then
    diffopt = diffopt:gsub('iwhite', '')
  else
    diffopt = (#diffopt > 0 and diffopt .. ',iwhite' or 'iwhite')
  end
  vim.api.nvim_set_option('diffopt', diffopt)
end
local function toggle_diff_algorithm()
  local diffopt = vim.api.nvim_get_option('diffopt')

  if diffopt:find('algorithm:myers') then
    diffopt = diffopt:gsub('algorithm:myers', 'algorithm:patience')
    print("Switched to patience algorithm")
  elseif diffopt:find('algorithm:patience') then
    diffopt = diffopt:gsub('algorithm:patience', 'algorithm:myers')
    print("Switched to myers algorithm")
  else
    diffopt = (#diffopt > 0 and diffopt .. ',algorithm:myers' or 'algorithm:myers')
  end

  vim.api.nvim_set_option('diffopt', diffopt)
end

-- g is for git
wk.add {
  { "<leader>g", group = "GIT" },
  { "<leader>gc", group = "Compare" },
  { "<leader>gcc", compare_to_clipboard,  desc = "Clipboard" },
  { "<leader>gcs", diffWithSaved, desc = "Diff with saved" },
  { "<leader>gd", group = "DiffView" },
  -- { "<leader>gdd", ":DiffviewOpen<CR>", desc = "Diffview Open" },
  { "<leader>gdf", ":DiffviewFileHistory %<CR>", desc = "Diffview File History" },
  { "<leader>gdh", ":DiffviewFileHistory --base=LOCAL %<CR>", desc = "Diffview File History (LOCAL)" },
  { "<leader>gdd", function()
      if next(require("diffview.lib").views) == nil then
        vim.cmd('DiffviewOpen')
      else
        vim.cmd('DiffviewClose')
      end
    end, desc = "Toggle Diffview"},
  { "<leader>gdl", "<Cmd>.DiffviewFileHistory --follow<CR>", desc = "File history for the current line" },
  { "<leader>gds", "<Cmd>'<,'>DiffviewFileHistory --follow<CR>",  desc = 'Selection history'},
  { "<leader>gdi", toggle_iwhite, desc = "Toggle iwhite" },
  { "<leader>gda", toggle_diff_algorithm, desc = "Toggle Diff Algorithm" },

  { '<leader>ghp', group = 'Pull Request' },
  { '<leader>ghpc', '<cmd>GHClosePR<cr>', desc = 'Close' },
  { '<leader>ghpd', '<cmd>GHPRDetails<cr>', desc = 'Details' },
  { '<leader>ghpe', '<cmd>GHExpandPR<cr>', desc = 'Expand' },
  { '<leader>ghpo', '<cmd>GHOpenPR<cr>', desc = 'Open' },
  { '<leader>ghpp', '<cmd>GHPopOutPR<cr>', desc = 'PopOut' },
  { '<leader>ghpr', '<cmd>GHRefreshPR<cr>', desc = 'Refresh' },
  { '<leader>ghpt', '<cmd>GHOpenToPR<cr>', desc = 'Open To' },
  { '<leader>ghpz', '<cmd>GHCollapsePR<cr>', desc = 'Collapse' },

  { "<leader>gn", ":Neogit<CR>", desc = "NeoGit" },
  { "<leader>gg", ":FloatermNew lazygit<CR>", desc = "LazyGit" },
  { "<leader>gn", group = "Neogit" },
  { "<leader>go", ":diffget<CR>", desc = "Obtain(do)" },
  { "<leader>gp", ":diffput<CR>", desc = "Put(dp)" },
  { "<leader>gt", ":diffthis<CR>", desc = "Diff This" },
  { "<leader>gu", ":diffupdate<CR>", desc = "Update changes" },
  { "<leader>gw", ":windo diffthis<cr>", desc = "Diff visible windows" },
}
wk.add{
  mode = { "v" },
  { "<leader>gc", group = "Compare" },
  { "<leader>gcc", compare_clipboard_selection, desc = "Diff with clipboard" },

}
-- ['h'] - taken by git_sign - hunk oper
-- ['A'] = {':Git add %'                        , 'add current'},
-- ['S'] = {':!git status'                      , 'status'},

wk.add {
  { "<leader>h", group = "History" },
  { "<leader>hD", ":DiffSaved<CR>", desc = "Diff with saved" },
  { "<leader>hb", ":LHBrowse<CR>", desc = "Local History Browse" },
  { "<leader>hd", ":LHDiff<CR>", desc = "Local History Diff" },
  { "<leader>hh", ":Gclog<CR>", desc = "File rev history" },
  { "<leader>hl", ":LHLoad<CR>", desc = "Local History Load" },
  { "<leader>hu", ":UndotreeToggle<CR>", desc = "Undo Tree" },
  { "<leader>hw", ':call v:lua.CmdInput("LHWrite %s")<CR>', desc = "Local History Write" },
  { "<leader>hx", ":LHDelete<CR>", desc = "Local History Delete" },
}

wk.add {
  { "<leader>j", group = "Jump" },
  { "<leader>jc", ":HopChar1<cr>", desc = "HopChar1" },
  { "<leader>jl", ":HopLineStart<cr>", desc = "HopLineStart" },
  { "<leader>ju", ':lua require("tsht").move({ side = "start" })<cr>', desc = "Jump Node" },
  { "<leader>jw", ":HopWord<cr>", desc = "HopWord" },
}

wk.add {
  { "<leader>l", group = "LSP" },
  { "<leader>lA", ":lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "Add Workspace Folder" },
  { "<leader>lD", ":lua vim.lsp.buf.declaration()<CR>", desc = "Declaration (gD)" },
  { "<leader>lK", ":lua vim.lsp.buf.hover()<CR>", desc = "Hover (K)" },
  { "<leader>lL", ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR><CR>", desc = "List Workspace Folders" },
  { "<leader>lR", ":lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "Remove Workspace Folder" },
  { "<leader>lT", group = "Telescope" },
  { "<leader>lTA", ":Telescope lsp_range_code_actions<CR>", desc = "Range Code Actions" },
  { "<leader>lTD", ":Telescope lsp_document_diagnostics<CR>", desc = "Document Diagnostics" },
  { "<leader>lTS", ":Telescope lsp_workspace_symbols<CR>", desc = "Workspace Symbols" },
  { "<leader>lTa", ":Telescope lsp_code_actions<CR>", desc = "Code Actions" },
  { "<leader>lTd", ":Telescope lsp_definitions<CR>", desc = "Definitions" },
  { "<leader>lTr", ":Telescope lsp_references<CR>", desc = "References" },
  { "<leader>lTs", ":Telescope lsp_document_symbols<CR>", desc = "Document Symbols" },
  { "<leader>la", ":lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
  { "<leader>ld", "<cmd>lua vim.diagnostic.setloclist()<CR>", desc = "Diagnostics to LocList" },
  { "<leader>lf", ":lua vim.lsp.buf.format()<CR>", desc = "Formatting" },
  { "<leader>lh", ":lua vim.lsp.buf.signature_help()<CR>", desc = "Signature Help" },
  { "<leader>li", ":lua vim.lsp.buf.implementation()<CR>", desc = "Implementation (gi)" },
  { "<leader>lr", ":lua vim.lsp.buf.references()<CR>", desc = "References (gr)" },
  { "<leader>ls", ":lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
  { "<leader>lt", ":LspTroubleToggle<CR>", desc = "Lsp Trouble Toggle" },
}

wk.add {
  { "<leader>L", group = "LLAMA" },
  { "<leader>LL", ":Gen<CR>", desc = "LLama" },
  -- ['<leader>LD'] = {':LlmDelete<CR>',                                    'Delete last Ouput'},
  -- ['<leader>LC'] = {':LlmCancel<CR>',                                    'Cancell last Ouput'},
}

wk.add {
  { "<leader>L", group = "LLAMA", mode = "v" },
  { "<leader>LL", ":Gen<cr>", desc = "LLama", mode = "v" },
}

-- Fold All toggle
-- -- vim.api.nvim_set_keymap( "n", "<F1>",  vim.cmd([[&foldlevel='zM'?'zR' ]]), { expr = true, noremap = true, silent = true } )
-- vim.api.nvim_set_keymap( "n", "<S-F1>",  'v=lua.conditional_fold()',  { expr = true, noremap = true, silent = true } )

function _G.conditional_fold()
  if vim.wo.foldlevel > 0 then
    vim.cmd ";normal zM"
  else
    vim.cmd ";normal zR"
  end
end

function _G.conditional_width()
  local wwidth = vim.api.nvim_eval "&winwidth"
  if wwidth > 10 then
    vim.cmd ":set winwidth=1" -- disable
  else
    vim.cmd ":set winwidth=90"
  end
end
-- below is required or else which key wont work !!
-- vim.api.nvim_set_keymap( "n", "<Leader>ww",  'v=lua.conditional_width()',  {expr = true, noremap = true, silent = true } )

wk.add {
  { "<leader>o", group = "Open" },
  { "<leader>o/", "q/", desc = "Search History (q/)" },
  { "<leader>oE", ":Ex<CR>", desc = "Open Explorer(Ex)" },
  { "<leader>oO", ":SymbolsOutline<CR>", desc = "Outliner (lsp)" },
  { "<leader>oT", ':!alacritty --working-directory "%:p:h"<CR>', desc = "Terminal External" },
  { "<leader>oU", ":UndotreeToggle<CR>", desc = "Undo Tree" },
  { "<leader>oa", ":AerialOpen float<cr>", desc = "Open Outliner (Aerial)" },
  { "<leader>od", ":Dirbuf<CR>", desc = "Dirbuf" },
  { "<leader>of", ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>", desc = "File Browser (fuzzy)" },
  { "<leader>oh", "q:", desc = "Commands History (q:)" },
  { "<leader>oo", ":lopen<CR>", desc = "Loclist (lopen)" },
  { "<leader>oq", ":copen<CR>", desc = "Quickfix (copen)" },

  {
    "<leader>or",
    function()
      require("hydra").spawn["snip_hydra"]()
    end,
    desc = "REPL Hydra (SnipRun)",
  },
  -- { "<leader>ol", ":lua require('lua-console.utils').load_saved_console()<CR>", desc = "LuaConsle" },
  { "<leader>ol", ":LuaConsole AttachToggle<CR>", desc = "LuaConsle Attach" },
  { "<leader>ot", ":FloatermNew<CR>", desc = "Term Float" },
}

-- function _G.replace_word()
--	local name = vim.fn.input('To: ')
--	vim.cmd(":.,$s/\\<"..vim.fn.expand('<cword>').."\\>/"..name.."/gc|1,''-&&") -- substitute and ask each time
-- end
wk.add {
  -- ['<leader>r*'] = {":let @/=expand('<cword>')<cr>cgn",        'Replace word with yank'},
  -- ['<leader>s*'] = {":.,$s/\\<<C-r><C-w>\\>/<C-r>+/gc|1,''-&&<CR>",  'Replace word with yank', mode='n'},       -- \<word\>  -adds whitespace  word limit (sub only whole words)
  -- ['<leader>s/'] = {":lua require('searchbox').replace({default_value = vim.fn.expand('<cword>'), confirm = 'menu'})<CR>", 'Find and Replace word'},       -- write to reg z (@a) then use it for replacign * word
  -- ['<leader>s*'] = {[["ayiw:lua require('searchbox').replace({confirm='menu'})<CR><C-r>=getreg('a')<CR><CR>:sl m<CR><C-r>=getreg('"')<CR>]], 'Replace word'},       -- write to reg z (@a) then use it for replacign * word
  { "<leader>s", group = "Substitute" },
  {
    "<leader>s/",
    function()
      local name = vim.fn.input("To: ", vim.fn.expand "<cword>")
      -- & - synonym for :s - repeat last subsittute
      -- e - no error if no match
      -- & - reuse last search flags
      vim.cmd(":.,$s/\\<" .. vim.fn.expand "<cword>" .. "\\>/" .. name .. "/gce|1,''-&&")
    end,
    desc = "Replace word",
  },
  { "<leader>sp", group = "Project" },
  { "<leader>sp*", "<Plug>CtrlSFCCwordPath<CR>", desc = "CtrlSF Word" },
  { "<leader>spc", "<Plug>CtrlSFPrompt -R {regex} -G *.py", desc = "CtrlSF" },
  { "<leader>spe", "<plug>(operator-esearch-prefill)<CR>", desc = "Esearch" },
  { "<leader>spa", ":lua require('grug-far').open({ engine='astgrep', prefills = { search = vim.fn.expand('<cword>') } })<CR>", desc = "GrugFar AST" },
  { "<leader>sps", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", desc = "Spectre" }, -- select word wont work
  { "<leader>ss", ":lua require('spectre').open_file_search({select_word=true})<CR>", desc = "Spectre Local" },
}
local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

wk.add { -- second one for visual mode
  mode = { "v" },
  { "<leader>sp", group = "Project" },
  { "<leader>sp*", "<Plug>CtrlSFVwordPath<CR>", desc = "CtrlSF Word" },
  { "<leader>sp/", "\"ay:lua require('spectre').open({select_word=true})<cr>\"aPa", desc = "Spectre" },
  { "<leader>spc", "<Plug>CtrlSFPrompt -R {regex} -G *.py", desc = "CtrlSF" },
}

wk.add { -- second one for visual mode
  mode = { "v" },
  { "<leader>s", group = "Substitute" },
  { "<leader>s*", "\"ay:.,$s/<C-r>a/<C-r>+/gc|1,''-&&<CR>", desc = "Replace word with yank" },
  {
    "<leader>s/",
    function()
      vim.cmd 'normal! "ay'
      local name = vim.fn.input("To: ", vim.fn.getreg "a")
      vim.cmd(":.,$s/" .. vim.fn.getreg "a" .. "/" .. name .. "/gc|1,''-&&")
    end,
    desc = "Replace word",
  },
  { "<leader>ss", ":lua require('spectre').open_file_search()<CR>", desc = "Spectre Local" },
}

-- MiniSessions.write(nil, {force = true})
-- function to save current session, close all buffers and open MiniStarter.open() - startup screen

function Save_current_session()
  if vim.v.this_session ~= "" then
    MiniSessions.write(nil, { force = true })
    print "Saved Session"
  end
end

local function StarterOpen()
  Save_current_session()
  local buffers = vim.api.nvim_list_bufs()
  for _, buffer in ipairs(buffers) do
    vim.api.nvim_buf_delete(buffer, { force = true })
  end
  MiniStarter.open()
  vim.fn.feedkeys(t "<CR>")
end

wk.add {
  -- Startify
  -- ['<leader>Ps'] = {':SSave<CR>',                                                     'Sesion Save'}  ,
  -- ['<leader>Pl'] = {':SLoad<CR>',                                                     'Sesion Load'}  ,
  -- ['<leader>Pc'] = {':SClose<CR>',                                                    'Sesion Close'} ,
  -- ['<leader>Pd'] = {':SDelete<CR>',                                                   'Sesion Delete'},
  -- ['<leader>Pf'] = {':Telescope live_grep<CR>',                                       'Find (live grep)'}     ,
  -- ['<leader>Pz'] = {":lua require'telescope.builtin'.grep_string{path_display = {'tail'}, word_match = '-w', only_sort_text = true, search = '' }<CR>", 'Find fuzzy'},

  { "<leader>S", group = "Session" },
  { "<leader>SS", StarterOpen, desc = "MiniStarter" },
  { "<leader>Sa", ":call v:lua.CmdInput(\"lua MiniSessions.write('%s')\")<CR>", desc = "Save as" },
  { "<leader>Sc", ":SClose<CR>", desc = "Session Close" },
  { "<leader>Sd", ":SDelete<CR>", desc = "Session Delete" },
  { "<leader>So", ":so /home/bartosz/.config/nvim/lua/settings.lua<CR>", desc = "Source Defaults" },
  { "<leader>Ss", Save_current_session, desc = "Save Current" },
}

wk.add {
  { "<leader>t", group = "Telescope" },
  { "<leader>tb", ":Telescope buffers<CR>", desc = "Buffers" },
  { "<leader>tc", ":Telescope colorscheme<CR>", desc = "colorscheme" },
  { "<leader>tf", ":lua require('telescope').extensions.file_browser.file_browser({initial_mode = 'normal', cwd = vim.fn.expand '%:p:h'})<CR><ESC>", desc = "File Browser (fuzzy)" },
  { "<leader>th", ":Telescope help_tags<CR>", desc = "Help" },
  { "<leader>to", ":Telescope oldfiles<CR>", desc = "Oldfiles" },
  { "<leader>ts", showDocumentSymbols, desc = "Buffer Symbols" },
  { "<leader>tt", ":Telescope<CR>", desc = "Telescope" },
}


wk.add {
  { "<leader>u", group = "UI" },
  { "<leader>ua", ":call v:lua.conditional_width()<CR>", desc = "Auto width" },
  { "<leader>uc", ":Telescope colorscheme<CR>", desc = "Colorscheme" },
  { "<leader>uh", ":set hlsearch!<CR>", desc = "Search highlight" },
  { "<leader>ul", ":set list!<CR>", desc = "Toggle List Chars" },
  { "<leader>ut", ":Twilight<cr>", desc = "Twilight" },
  { "<leader>uw", ":set wrap!<CR>", desc = "Toggle Wrap" },
  { "<leader>ux", ":NoNeckPain<CR>", desc = "Center (NoNeckPain)" },
  { "<leader>um", ":RenderMarkdown toggle<CR>", desc = "RenderMarkdown" },
  { "<leader>us", group = "Spell" },
  { "<leader>usa", "zg<CR>", desc = "Add To Dictionary (zg)" },
  { "<leader>uss", ":setlocal spell! spelllang=en_us<CR>", desc = "Toggle Spellcheck" },
  -- toggle diffopt = iwhite - toggle ON off - ignore whitespace
  {
    "<leader>ui",
    function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    desc = "Toggle Inlay [H]ints",
  },

  -- Global Minimap Controls
  { "<leader>um", group = "Minimap" },
  { "<leader>umm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
  -- { "<leader>umr", "<cmd>Neominimap refresh<cr>", "Refresh global minimap" },

  -- Buffer-Specific Minimap Controls
  { "<leader>umt", "<cmd>Neominimap bufToggle<cr>", desc = "Toggle minimap for current buffer" },
  { "<leader>umr", "<cmd>Neominimap bufRefresh<cr>", desc = "Refresh minimap for current buffer" },

  -- Focus Controls
  { "<leader>umf", "<cmd>Neominimap toggleFocus<cr>", desc = "Switch focus on minimap" },
}

-- n is for Window
wk.add {
  { "<leader>w", group = "Window" },
  { "<leader>w<", ":vertical resize -25<CR>", desc = "Decrease(<)" },
  { "<leader>w=", "<C-w>=<CR>", desc = "Equalize(=)" },
  { "<leader>w>", ":vertical resize +25<CR>", desc = "Increase(>)" },
  { "<leader>wO", ":only<CR>", desc = "Close All other splits(o)" },
  { "<leader>wa", ":call v:lua.conditional_width()<CR>", desc = "Auto width" },
  { "<leader>wh", "<C-w>s<CR>", desc = "Split below(s)" },
  { "<leader>wo", "<C-w>o<CR>", desc = "Close All but current(o)" },
  { "<leader>wq", "<C-w>q<CR>", desc = "Quit window(q)" },
  { "<leader>wv", "<C-w>v<CR>", desc = "Split right(v)" },
  { "<leader>ww", ':call v:lua.CmdInput(":set winwidth=")<CR>', desc = "Set width" },
  -- ['<leader>wm'] = {':call v:lua.CmdInput(":set winminwidth=")<CR>',  'Set min width'},
  -- ['<leader>wm'] = {':WindowsMaximize<CR>',  'Maximize'},  -- anuvyklack/windows.nvim  plug
}

-- TSContextDisable - if srm treesitter-context
wk.add {
  { "<leader>q", group = "Quit" },
  { "<leader>qf", ":q!<CR>", desc = "Force Quit (q!)" },
  { "<leader>qq", "<cmd>TSContext disable<cr>|:call v:lua.Save_current_session()<CR>|:confirm qa", desc = "Quit Confirm (qa)" },
  { "<leader>qs", ":bufdo update | q!<CR>", desc = "Quit Save all (wqa!)" },
}
wk.add { -- second one for visual mode
  { "<leader>q", group = "Quit", mode = "v" },
  { "<leader>qq", ":<ESC>|:TSContextDisable<cr>|:call v:lua.Save_current_session()<CR>|:confirm qa<cr>", desc = "Quit Confirm (qa)", mode = "v" },
}

-- TEMP fix for https://github.com/folke/which-key.nvim/issues/273  -- window closed immediately error when using Telescope
local show = wk.show
wk.show = function(keys, opts)
  if vim.bo.filetype == "TelescopePrompt" then
    local map = "<c-r>"
    local key = vim.api.nvim_replace_termcodes(map, true, false, true)
    vim.api.nvim_feedkeys(key, "i", true)
  end
  show(keys, opts)
end -- Register which key map
