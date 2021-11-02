local M = {}

local setup = function()
  require("Comment").setup({
    mappings = {
      extended = true,
    },
  })
end

function M.use(use)
  use({
    "numToStr/Comment.nvim",
    opt = true,
    wants = "nvim-ts-context-commentstring",
    keys = { "gc", "gcc" },
    config = setup,
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
  })
end

return M
