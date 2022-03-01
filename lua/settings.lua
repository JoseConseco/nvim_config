-- vim.o -- Get or set editor options (:set)
-- vim.bo -- Get or set buffer-scoped |local-options|
-- vim.wo -- Get or set window-scoped local options (:set)

vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
--vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
-- vim.opt.hidden = true -- Required to keep multiple buffers open multiple buffers- defaut true since ver 6.0
vim.wo.wrap = false -- Display long lines as just one line
vim.opt.listchars=""   -- hide listchars -> whitespaces chars
vim.cmd([[setlocal nolist]]) -- wont work

vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
vim.cmd('set noswapfile') -- move to next line with theses keys
-- vim.cmd("set diffopt+=iwhite") --avoid comparing whitespaces  - but breaks diff obtain?
vim.opt.pumheight = 10 -- Makes popup menu smaller
vim.opt.fileencoding = "utf-8" -- The encoding written to file
vim.opt.cmdheight = 1 -- More space for displaying messages
vim.opt.mouse = "a" -- Enable your mouse
vim.opt.linespace = 0 -- spacing between lines
vim.opt.splitbelow = true -- Horizontal splits will automatically be below
vim.opt.termguicolors = true -- set term giu colors most terminals support this
vim.opt.splitright = true -- Vertical splits will automatically be to the right
-- vim.o.t_Co = "256" -- Support 257 colors - broken after nvim udpate
vim.opt.scrolloff = 6 -- Makes indenting smart
-- vim.o.conceallevel = 0 -- So that I can see `` in markdown files
-- vim.g.tex_conceal = ''--'dmgs' --a - disables ligatures
-- vim.g.cole = 0

vim.bo.expandtab = true -- Converts tabs to spaces
vim.opt.tabstop=4 -- width of <Tab> - if no tabExpand
vim.opt.softtabstop=4 -- backspace will delete 4 spaces
vim.opt.shiftwidth=4 -- Change the number of space characters inserted for indentation
vim.bo.smartindent = true -- Makes indenting smart

vim.opt.incsearch = true --  show partially typed result for searc
vim.opt.inccommand = "nosplit" --  show partially substituted results "split"	 : Also shows partial off-screen results
vim.opt.ignorecase = true    -- ignore case of searched term
vim.opt.smartcase = true   -- disable ignorecase if typed in command has Upper case letter

vim.opt.number = true -- set numbered lines
-- vim.wo.relativenumber = true -- set numbered lines
vim.opt.cursorline = true -- Enable highlighting of the current line
vim.opt.showtabline = 2 -- Always show tabs
vim.opt.linebreak = true  -- do not break words.
vim.opt.backup = false -- This is recommended by coc
vim.opt.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.opt.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.virtualedit='all'      -- makes cursor not jump,

vim.opt.winwidth=60
vim.opt.winminwidth=50

vim.g.paste = true --? format pasted str - does it work? seems broken right now..

-- vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono, Medium:h8"     -- icons ok, but ugly
vim.o.guifont = "Source Code Pro SemiBold:h11"  -- icons missng
-- vim.o.guifont = "FiraCode Nerd Font:h11"   --acutally OK
-- vim.o.guifont = "NotoSansMono Nerd Font Medium:h12" -- missing icons
vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency=1.0

if vim.g.nvui then
	print('nvi')
end

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
	local white_chars = line:match("^%s*") -- find 0 or more white spaces at beginning of line
  -- return string.rep(' ', vim.v.foldlevel*4).."[+] ["..line_count .. " Lines]. fold lev:"..vim.v.foldlevel -- .. line
  return white_chars.."[+] ["..line_count .. " Lines]"
end

vim.opt.foldtext = 'v:lua.custom_fold_text()'
-- vim.opt.fillchars = { eob = "-", fold = "=" }
vim.opt.foldminlines = 3  -- fold only if more than 2 lines in code block
vim.opt.foldnestmax = 3  -- create max 4 folds (avoids too many fold levels)

