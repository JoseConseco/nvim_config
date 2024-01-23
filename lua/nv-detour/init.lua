local function close_on_leave(popup_id)
    -- This autocmd will close the created detour popup when you focus on a different window.
    vim.api.nvim_create_autocmd({ "WinEnter" }, {
        callback = function()
            local window_id = vim.api.nvim_get_current_win()
            -- Skip cases where we are entering popup menus or the detour popup itself.
            if vim.api.nvim_win_get_config(window_id).relative ~= "" or window_id == popup_id then
                return
            end

            -- Check to make sure the popup has not already been closed
            if vim.tbl_contains(vim.api.nvim_list_wins(), popup_id) then
                vim.api.nvim_win_close(popup_id, false)
            end

            -- delete this autocmd if the popup was closed
            return not vim.tbl_contains(vim.api.nvim_list_wins(), popup_id)
        end,
    })
end

vim.keymap.set("n", "<c-w><enter>", function()
    local ok = require("detour").Detour() -- Open a detour popup

    if ok then
        close_on_leave(vim.api.nvim_get_current_win())
    end
end)

vim.keymap.set("n", "gD", function ()
    local ok = require("detour").Detour() -- Open a detour popup
    -- Call this function whether or not a detour popup was successfully created. This means we fallback to using the current window if the popup failed.
    require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})

    if ok then
        close_on_leave(vim.api.nvim_get_current_win())
    end
end)

