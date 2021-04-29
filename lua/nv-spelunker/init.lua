vim.g.enable_spelunker_vim = 0
-- Highlight type: (default: 1)
--1: Highlight all types (SpellBad, SpellCap, SpellRare, SpellLocal).
--2: Highlight only SpellBad.
vim.g.spelunker_highlight_type = 2

vim.g.spelunker_target_min_char_len=5


-- Spellcheck type: (default: 1)
-- 1: File is checked for spelling mistakes when opening and saving. This
-- may take a bit of time on large files.
-- 2: Spellcheck displayed words in buffer. Fast and dynamic. The waiting time
-- depends on the setting of CursorHold `set updatetime=1000`.
vim.g.spelunker_check_type = 2

-- Option to disable word checking.
-- " Disable URI checking. (default: 0)
vim.g.spelunker_disable_uri_checking = 1
vim.g.spelunker_disable_email_checking = 1
vim.g.spelunker_disable_acronym_checking = 1
vim.g.spelunker_white_list_for_user = {'Bartosz','Styperek', 'vimrc', 'vim', 'Startify'}
