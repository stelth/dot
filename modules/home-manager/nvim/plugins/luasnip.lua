require("luasnip").config.set_config({
  history = true,
  -- Update more often
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").lazy_load()
