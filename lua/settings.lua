vim.cmd('set iskeyword+=-') -- treat dash separated words as a word text object"
--vim.cmd('set shortmess+=c') -- Don't pass messages to |ins-completion-menu|.
vim.o.hidden = true -- Required to keep multiple buffers open multiple buffers
vim.wo.wrap = false -- Display long lines as just one line
vim.cmd('set whichwrap+=<,>,[,],h,l') -- move to next line with theses keys
vim.o.pumheight = 10 -- Makes popup menu smaller
vim.o.fileencoding = "utf-8" -- The encoding written to file
vim.o.cmdheight = 2 -- More space for displaying messages
vim.o.mouse = "a" -- Enable your mouse
vim.o.linespace = 14 -- spacing between lines
vim.o.splitbelow = true -- Horizontal splits will automatically be below
vim.o.termguicolors = true -- set term giu colors most terminals support this
vim.o.splitright = true -- Vertical splits will automatically be to the right
vim.o.t_Co = "256" -- Support 257 colors
vim.o.scrolloff = 8 -- Makes indenting smart
-- vim.o.conceallevel = 0 -- So that I can see `` in markdown files


vim.bo.expandtab = true -- Converts tabs to spaces
vim.o.tabstop=4 -- Insert 4 spaces for a tab
vim.o.shiftwidth=4 -- Change the number of space characters inserted for indentation
vim.bo.smartindent = true -- Makes indenting smart

vim.o.incsearch = true --  show partially typed result for searc
vim.o.inccommand = "nosplit" --  show partially substituted results "split"	 : Also shows partial off-screen results
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.number = true -- set numbered lines
vim.wo.relativenumber = true -- set numbered lines
vim.wo.cursorline = true -- Enable highlighting of the current line
vim.o.showtabline = 2 -- Always show tabs
vim.o.linebreak = true  -- do not break words.
vim.o.backup = false -- This is recommended by coc
vim.o.writebackup = false -- This is recommended by coc
vim.wo.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.o.updatetime = 300 -- Faster completion
vim.o.timeoutlen = 100 -- By default timeoutlen is 1000 ms
vim.o.clipboard = "unnamedplus" -- Copy paste between vim and everything else
vim.o.guifont = "Hack:h30"
vim.o.virtualedit='all'      -- makes cursor not jump,




