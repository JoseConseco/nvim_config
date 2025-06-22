require'sniprun'.setup({
  display = { "VirtualLine" }, -- "Classic" | "VirtualText" | "TempFloatingWindow" | "LongTempFloatingWindow" | "Terminal"
})

 -- _r_: Run Sel
 -- _b_: Run Buffer
local hint = [[
 _R_: Run To Cursor
 ^ ^              _q_: Exit
]]

local Hydra = require "hydra"

local snip_hydra = nil
local snip_au_group = vim.api.nvim_create_augroup("SnipRunHydraAu", { clear = true })
local snip_bufnr = nil

local function show_snip_hydra()
  snip_hydra = Hydra {
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      desc = "SnipRun Hydra",
      hint = {
        position = "bottom",
        float_opts = { border = 'rounded' }
      },
    },
    name = "SnipRun",
    mode = { "n", "x", "v" },
    body = "<leader>or", -- You can change this to your preferred activation key
    heads = {
      -- { "r", "<Plug>SnipRun", { silent = true } },
      -- { "o", "<Plug>SnipRunOperator", { silent = true } },
      { "R", ":let b:caret=winsaveview() <CR> | :%SnipRun <CR>| :call winrestview(b:caret) <CR>", { silent = true } },
      -- { "c", ":let b:caret=winsaveview() <CR> | :lua require'sniprun.api'.run_range(1, vim.api.nvim_win_get_cursor(0)[1]) <CR> | :call winrestview(b:caret) <CR>", { silent = true } },
      -- { "R", ":lqet b:caret=winsaveview() <CR> | :lua require'sniprun.api'.run_range(1, vim.api.nvim_win_get_cursor(0)[1]) <CR> | :call winrestview(b:caret) <CR>", { silent = true } },
      { "q", function()
        vim.api.nvim_clear_autocmds({ group = snip_au_group })
        snip_bufnr = nil
      end, { exit = true, nowait = true } },
    },
  }
  snip_bufnr = vim.api.nvim_get_current_buf()
  snip_hydra:activate()
end

-- Setup spawn function for external activation
Hydra.spawn = Hydra.spawn or {}
Hydra.spawn["snip_hydra"] = function()
  show_snip_hydra()

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*",
    callback = function(opts)
      -- print("BufEnter: buf " .. opts.buf .. " valid: " .. tostring(vim.api.nvim_buf_is_valid(opts.buf)))
      -- print("BufEnter: filetype " .. vim.bo[opts.buf].filetype .. " snip_ft: " .. snip_ft)
      -- print("dap_hydra: " .. tostring(dap_hydra))
      -- if dap.session() == nil then
      --   return true -- close autocmd
      -- end
      if vim.api.nvim_buf_is_valid(opts.buf) and opts.buf == snip_bufnr then
        -- print("Show dap")
        show_snip_hydra()
      else
        if snip_hydra and vim.bo[opts.buf].filetype ~= 'hydra_hint' then
          -- print("Exit dap hydra")
          snip_hydra:exit()
        end
      end
      -- return true -- finish au
    end,
    group = snip_au_group,
  })
end

-- Optional: Export the show function if you want to use it directly
return {
  show_snip_hydra = show_snip_hydra
}

