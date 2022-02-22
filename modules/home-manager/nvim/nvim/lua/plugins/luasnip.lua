local M = {}

M.setup = function()
  local luasnip = require("luasnip")

  luasnip.config.set_config({
    history = false,
    -- Update more often
    updateEvents = "TextChanged,TextChangedI",
  })

  require("luasnip/loaders/from_vscode").load()
end

return M
