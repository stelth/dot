local M = {}

local setup = function()
  require("bqf").setup({
    auto_resize_height = false,
  })
end

M.use = function(use)
  use({
    "kevinhwang91/nvim-bqf",
    config = setup,
  })
end

return M
