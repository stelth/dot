local M = {}

local setup = function()
  vim.notify = require("notify")
end

M.use = function(use)
  use({
    "rcarriga/nvim-notify",
    config = setup,
  })
end

return M
