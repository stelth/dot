local M = {}

local setup = function()
  vim.g.illuminate_delay = 1000
end

M.use = function(use)
  use({
    "RRethy/vim-illuminate",
    config = setup,
  })
end

return M
