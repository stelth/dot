local M = {}

M.setup = function()
  vim.g.mergetool_layout = "mr"
  vim.g.mergetool_prefer_revision = "local"
end

return M
