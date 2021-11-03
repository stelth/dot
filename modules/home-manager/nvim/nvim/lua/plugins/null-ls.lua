local M = {}

local setup = function() end

M.use = function(use)
  use({
    "jose-elias-alvarez/null-ls.nvim",
    module = "null-ls",
    config = setup,
  })
end

return M
