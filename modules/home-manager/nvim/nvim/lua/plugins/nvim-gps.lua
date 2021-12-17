local M = {}

local setup = function()
  require("nvim-gps").setup({
    separator = " ",
  })
end

M.use = function(use)
  use({
    "SmiteshP/nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    module = "nvim-gps",
    config = setup,
  })
end

return M
