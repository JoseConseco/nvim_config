vim.g.ayucolor="mirage" --mirage, dark
vim.g.ayu_italic_comment = 1 -- def 0
vim.g.ayu_sign_contrast = 1 -- defaults to 0. If set to 1, SignColumn and FoldColumn will have a higher contrast instead of using the Normal background

-- Customize The Theme To Your Likin
-- vim.cmd([[
-- function! s:custom_ayu_colors()
--   " Put whatever highlights you want here.
--   " The ayu#hi function is defined as followed:
--   " ayu#hi(highlight_group, foreground, background, [gui options])
--   " See autoload/ayu.vim for color palette.
--   " `foreground` and `background` are required while the gui options are optional
--   " `gui options` only represents the values you could put in the `gui` part of the highlight. See `:h highlight-gui`.
--   call ayu#hi('IncSearch', '', 'vcs_modified')
-- endfunction

-- augroup custom_colors
--   autocmd!
--   autocmd ColorScheme ayu call s:custom_ayu_colors()
-- augroup END
-- ]])
