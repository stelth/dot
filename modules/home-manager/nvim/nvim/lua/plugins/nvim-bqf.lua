local M = {}

local setup = function() end

function M.use(use)
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  })
end

return M
