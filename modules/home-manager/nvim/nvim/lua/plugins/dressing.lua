local M = {}

local setup = function() end

M.use = function(use)
  use({
    "stevearc/dressing.nvim",
    event = "BufReadPre",
    config = setup,
  })
end

return M
