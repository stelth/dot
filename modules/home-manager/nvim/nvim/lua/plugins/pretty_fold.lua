local M = {}

local setup = function()
  require("pretty-fold").setup()
  require("pretty-fold.preview").setup_keybinding("h")
end

M.use = function(use)
  use({
    "anuvyklack/pretty-fold.nvim",
    config = setup,
  })
end

return M
