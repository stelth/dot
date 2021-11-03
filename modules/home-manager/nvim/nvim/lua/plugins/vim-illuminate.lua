local M = {}

local setup = function()
  vim.g.illuminate_delay = 1000
end

function M.use(use)
  use({
    "RRethy/vim-illuminate",
    event = "CursorHold",
    module = "illuminate",
    config = setup,
  })
end

return M
