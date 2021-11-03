local M = {}

local setup = function() end

M.use = function(use)
  use({
    "folke/lua-dev.nvim",
    module = "lua-dev",
    config = setup,
  })
end

return M
