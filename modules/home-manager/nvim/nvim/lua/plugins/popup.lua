local M = {}

function M.use(use)
  use({
    "nvim-lua/popup.nvim",
    module = "popup",
  })
end

return M
