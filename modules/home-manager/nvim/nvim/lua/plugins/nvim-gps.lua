local M = {}

local setup = function()
  require("nvim-gps").setup({
    separator = " ",
  })
end

M.use = function(use)
  use({
    "SmiteshP/nvim-gps",
    module = "nvim-gps",
    requires = "nvim-treesitter/nvim-treesitter",
    config = setup,
  })
end

return M
