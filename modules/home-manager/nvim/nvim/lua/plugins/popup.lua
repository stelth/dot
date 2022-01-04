local M = {}

local setup = function() end

M.use = function(use)
  use({
    "nvim-lua/popup.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = setup,
  })
end

return M
