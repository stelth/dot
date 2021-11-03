local M = {}

local setup = function() end

M.use = function(use)
  use({
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    config = setup,
  })
end

return M
