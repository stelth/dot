local M = {}

local setup = function()
  require("Comment").setup({
    mappings = {
      extended = true,
    },
  })
end

M.use = function(use)
  use({
    "numToStr/Comment.nvim",
    opt = true,
    keys = { "gc", "gcc" },
    config = setup,
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
  })
end

return M
