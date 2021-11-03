local M = {}

local setup = function() end

M.use = function(use)
  use({
    "nvim-lua/popup.nvim",
    module = "popup",
    config = setup,
  })
end

return M
