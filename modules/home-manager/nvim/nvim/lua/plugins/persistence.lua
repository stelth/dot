local M = {}

local setup = function()
  require("persistence").setup()
end

function M.use(use)
  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = setup,
  })
end

return M
