local M = {}

local setup = function()
  vim.g.copilot_no_tab = true
  vim.g.copilot_assume_mapped = true
  vim.g.copilot_tab_fallback = ""
end

function M.use(use)
  use({
    "github/copilot.vim",
    config = setup,
  })
end

return M
