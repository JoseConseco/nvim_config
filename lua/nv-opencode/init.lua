local opencode = {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    -- vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
    -- vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Select opencode…" })
    -- vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
vim.api.nvim_create_user_command("OpenCode", function() require("opencode").toggle() end, { desc = "Opencode Toggle" })
vim.api.nvim_create_user_command("OpenCodeActions", function() require("opencode").select() end, { desc = "Opencode Actions" })

vim.api.nvim_create_user_command("OpenCodeAskSelected", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask about selection" , range = true})
vim.api.nvim_create_user_command("OpenCodeAskBuffer", function() require("opencode").ask("@buffer: ", { submit = true }) end, { desc = "Ask about buffer" })
vim.api.nvim_create_user_command("OpenCodeAsk", function() require("opencode").ask("", { submit = true }) end, { desc = "Ask (empty)" })
vim.api.nvim_create_user_command("OpenCodeOptimizeSelected", function() require("opencode").ask("@this optimize: ", { submit = true }) end, { desc = "Optimize selection" , range = true})
vim.api.nvim_create_user_command("OpenCodeFixSelected", function() require("opencode").ask("@this fix: ", { submit = true }) end, { desc = "Fix selection", range = true })
vim.api.nvim_create_user_command("OpenCodeExplainSelected", function() require("opencode").ask("@this explain: ", { submit = true }) end, { desc = "Explain selection", range = true })

      -- {
      --   "go",
      --   function()
      --     return require("opencode").operator("@this ")
      --   end,
      --   expr = true,
      --   mode = { "n", "x" },
      --   desc = "Add range to OpenCode",
      -- },

-- undo
vim.api.nvim_create_user_command("OpenCodeUndo", function() require("opencode").command("session.undo") end, { desc = "Undo last opencode action" })
-- interrupt
vim.api.nvim_create_user_command("OpenCodeInterrupt", function() require("opencode").command("session.interrupt") end, { desc = "Interrupt opencode" })
-- start new
vim.api.nvim_create_user_command("OpenCodeNew", function() require("opencode").command("session.new") end, { desc = "Start new opencode session" })

local M = {opencode}
return M
