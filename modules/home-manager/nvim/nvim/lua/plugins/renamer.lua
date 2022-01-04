local M = {}

local setup = function()
  require("renamer").setup()
end

M.use = function(use)
  use({
    "filipdutescu/renamer.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = setup,
  })
end

return M
