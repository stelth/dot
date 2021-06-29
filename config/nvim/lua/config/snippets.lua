local util = require("util")
local luasnip = require("luasnip")

luasnip.config.set_config({
  history = true,
  -- Update more often
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").load()

local function on_tab()
  return luasnip.jump(1) and "" or util.t("<Tab>")
end

local function on_s_tab()
  return luasnip.jump(-1) and "" or util.t("<S-Tab>")
end

util.imap("<Tab>", on_tab, { expr = true })
util.smap("<Tab>", on_tab, { expr = true })
util.imap("<S-Tab>", on_s_tab, { expr = true })
util.smap("<S-Tab>", on_s_tab, { expr = true })
