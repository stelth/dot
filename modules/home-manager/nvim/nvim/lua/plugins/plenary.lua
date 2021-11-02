local M = {}

function M.use(use)
  use({
    "nvim-lua/plenary.nvim",
    module = "plenary",
  })
end

return M
