local M = {}

local setup = function()
  vim.g.mergetool_layout = "mr"
  vim.g.mergetool_prefer_revision = "local"
end

function M.use(use)
  use({
    "samoshkin/vim-mergetool",
    cmd = "MergetoolStart",
    config = setup,
  })
end

return M
