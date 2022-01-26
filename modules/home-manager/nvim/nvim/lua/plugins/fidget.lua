local M = {}

local setup = function()
  require("fidget").setup({})
end

M.use = function(use)
  use({
    "j-hui/fidget.nvim",
    config = setup,
  })
end

return M
