local M = {}

local setup = function()
  local luasnip = require("luasnip")

  luasnip.config.set_config({
    history = true,
    -- Update more often
    updateEvents = "TextChanged,TextChangedI",
  })

  require("luasnip/loaders/from_vscode").load()
end

function M.use(use)
  use({
    "L3MON4D3/LuaSnip",
    event = "BufReadPre",
    module = "luasnip",
    requires = "rafamadriz/friendly-snippets",
    config = setup,
  })
end

return M
