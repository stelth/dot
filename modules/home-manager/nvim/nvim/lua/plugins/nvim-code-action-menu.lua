local M = {}

function M.use(use)
  use({
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  })
end

return M
