local M = {}

local setup = function()
  require("Comment").setup({})
end

M.use = function(use)
  use({
    "numToStr/Comment.nvim",
    config = setup,
  })
end

return M
