local M = {}

local setup = function()
  require("nord").set()
end

M.use = function(use)
  use({
    "shaunsingh/nord.nvim",
    config = setup,
  })
end

return M
