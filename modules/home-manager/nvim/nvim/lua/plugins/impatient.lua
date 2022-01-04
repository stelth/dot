local M = {}

local setup = function()
  require("impatient").enable_profile()
end

M.use = function(use)
  use({
    "lewis6991/impatient.nvim",
    config = setup,
  })
end

return M
