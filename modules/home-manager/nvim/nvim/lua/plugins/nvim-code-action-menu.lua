local M = {}

local setup = function() end

M.use = function(use)
  use({
    "weilbith/nvim-code-action-menu",
    config = setup,
  })
end

return M
