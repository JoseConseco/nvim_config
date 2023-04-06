local Hydra = require "hydra"

local hint = [[
 _K_: Eval    _U_: Update
 ^ ^          _q_: exit
]]

Hydra.spawn = Hydra.spawn or {}
Hydra.spawn["codi"] = function()
  local codi_hydra = Hydra {
    hint = hint,
    config = {
      color = "pink",
      invoke_on_body = true,
      buffer = 0,  -- only for active buffer
      desc = "Codi Hydra",
      hint = {
        position = "bottom",
        border = "rounded",
      },
    },
    name = "Codi",
    mode = { "n" },
    body = "H",
    heads = {
      { "K", '<Cmd>CodiExpand<cr>', { silent = true } },
      { "U", '<Cmd>CodiUpdate<cr>', { silent = true } },
      { "q", '<Cmd>Codi!<cr>', { exit = true, nowait = true } },
    },
  }
  codi_hydra:activate()
end
