local luasnip = require("luasnip")

luasnip.config.set_config({
  history = false,
  -- Update more often
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").lazy_load()
