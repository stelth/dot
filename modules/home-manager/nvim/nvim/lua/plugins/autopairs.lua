local M = {}

local setup = function()
  require("nvim-autopairs").setup({})
end

M.use = function(use)
  use({
    "windwp/nvim-autopairs",
    config = setup,
  })
end

return M
