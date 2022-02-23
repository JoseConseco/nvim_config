-- load plugins
if vim.fn.exists('g:vscode') then
    vim.opt.termguicolors = true -- set term gui colors most terminals support this

    -- require('plugins')
    -- vim.cmd('packloadall!') -- fixes plugs not seeing config, and load order mess. Or else we need to: so $MYVIMRC  but fucks up packer.sync...
--     require('settings')
    require('keymappings')



    --remove white spaces on save and restore cursor pos - using mark '.'
    vim.cmd('autocmd BufWritePre * let save_pos = getpos(".") | %s/\\s\\+$//e | call setpos(".", save_pos)')
    -- color active and unactive windows
    -- vim.cmd([[ set winhighlight=Normal:Normal,NormalNC:CursorLine ]]) -- for tokyo night


end
