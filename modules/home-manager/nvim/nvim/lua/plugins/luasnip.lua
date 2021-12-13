local M = {}

local setup = function()
  local luasnip = require("luasnip")

  luasnip.config.set_config({
    history = false,
    -- Update more often
    updateEvents = "TextChanged,TextChangedI",
  })

  require("luasnip/loaders/from_vscode").load()
end

M.use = function(use)
  use({
    "L3MON4D3/LuaSnip",
    module = "luasnip",
    requires = "rafamadriz/friendly-snippets",
    config = setup,
  })
end

return M
