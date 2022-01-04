local M = {}

local setup = function()
  require("filetype").setup({
    overrides = {
      extensions = {
        fish = "fish",
      },
    },
  })
end

M.use = function(use)
  use({
    "nathom/filetype.nvim",
    config = setup,
  })
end

return M
