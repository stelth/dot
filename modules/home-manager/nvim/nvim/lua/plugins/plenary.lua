local M = {}

local setup = function() end

M.use = function(use)
  use({
    "nvim-lua/plenary.nvim",
    module = "plenary",
    config = setup,
  })
end

return M
