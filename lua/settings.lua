-- vim.o -- Get or set editor options (:set)
-- vim.bo -- Get or set buffer-scoped |local-options|
-- vim.wo -- Get or set window-scoped local options (:set)

vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
--vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.wo.wrap = false -- Display long lines as just one line

vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
vim.cmd('set noswapfile') -- move to next line with theses keys
-- vim.cmd("set diffopt+=iwhite") --avoid comparing whitespaces  - but breaks diff obtain?
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 1 -- More space for displaying messages
vim.o.mouse = "a" -- Enable your mouse
vim.o.linespace = 0 -- spacing between lines
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.termguicolors = true -- set term giu colors most terminals support this
vim.o.splitright = true -- Vertical splits will automatically be to the right
-- vim.o.t_Co = "256" -- Support 257 colors - broken after nvim udpate
vim.o.scrolloff = 6 -- Makes indenting smart
-- vim.o.conceallevel = 0 -- So that I can see `` in markdown files
-- vim.g.tex_conceal = ''--'dmgs' --a - disables ligatures
-- vim.g.cole = 0

vim.bo.expandtab = true -- Converts tabs to spaces
vim.o.tabstop=4 -- width of <Tab> - if no tabExpand
vim.o.softtabstop=4 -- backspace will delete 4 spaces
vim.o.shiftwidth=4 -- Change the number of space characters inserted for indentation
vim.bo.smartindent = true -- Makes indenting smart

vim.o.incsearch = true --  show partially typed result for searc
vim.o.inccommand = "nosplit" --  show partially substituted results "split"	 : Also shows partial off-screen results
vim.o.ignorecase = true    -- ignore case of searched term
vim.o.smartcase = true   -- disable ignorecase if typed in command has Upper case letter

vim.wo.number = true -- set numbered lines
-- vim.wo.relativenumber = true -- set numbered lines
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.o.linebreak = true  -- do not break words.
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 500 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.virtualedit='all'      -- makes cursor not jump,

vim.o.winwidth=60
vim.o.winminwidth=50

-- vim.g.paste = true --? format pasted str - does it work? seems broken right now..

-- vim.o.guifont = "NotoSansMono Nerd Font:16"
vim.o.guifont = "NotoSansMono Nerd Font Medium:h12" -- "FiraCode Nerd Font:h14"
vim.g.neovide_refresh_rate = 60
vim.g.neovide_transparency=1.0

function _G.custom_fold_text()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
	local white_chars = line:match("^%s*") -- find 0 or more white spaces at beginning of line
  -- return string.rep(' ', vim.v.foldlevel*4).."[+] ["..line_count .. " Lines]. fold lev:"..vim.v.foldlevel -- .. line
  return white_chars.."[+] ["..line_count .. " Lines]"
end

vim.opt.foldtext = 'v:lua.custom_fold_text()'
-- vim.opt.fillchars = { eob = "-", fold = "=" }
vim.wo.foldminlines = 3  -- fold only if more than 2 lines in code block
vim.wo.foldnestmax = 3  -- create max 4 folds (avoids too many fold levels)

