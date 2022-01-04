local M = {}

local setup = function()
  vim.g.mergetool_layout = "mr"
  vim.g.mergetool_prefer_revision = "local"
end

M.use = function(use)
  use({
    "samoshkin/vim-mergetool",
    config = setup,
  })
end

return M
