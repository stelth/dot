local M = {}

local setup = function() end

M.use = function(use)
  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    config = setup,
  })
end

return M
