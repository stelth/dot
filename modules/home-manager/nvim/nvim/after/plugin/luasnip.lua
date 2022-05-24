local luasnip = require("luasnip")

luasnip.config.set_config({
  history = false,
  -- Update more often
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").load()

vim.keymap.set("i", "<TAB>", "", {
  callback = function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    else
      vim.api.nvim_replace_termcodes("<TAB>", true, true, true)
    end
  end,
  desc = "Expand/Jump Snippet",
})

vim.keymap.set("s", "<TAB>", "", {
  callback = function()
    luasnip.jump(1)
  end,
  desc = "Expand/Jump Snippet",
})

vim.keymap.set({ "i", "s" }, "<S-TAB>", "", {
  callback = function()
    luasnip.jump(-1)
  end,
  desc = "Expand/Jump Backwards Snippet",
})
