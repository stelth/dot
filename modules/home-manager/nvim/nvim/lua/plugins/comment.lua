local M = {}

local setup = function()
  require("Comment").setup({})
end

M.use = function(use)
  use({
    "numToStr/Comment.nvim",
    opt = true,
    keys = { "gc", "gcc", "gbc" },
    config = setup,
  })
end

return M
