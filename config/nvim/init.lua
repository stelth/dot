require("util")
require("options")

vim.defer_fn(function()
  require("bootstrap")
  require("plugins")
end, 0)

require("config.theme")
