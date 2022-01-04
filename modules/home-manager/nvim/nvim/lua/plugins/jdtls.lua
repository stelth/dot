local M = {}

local setup = function()
  require("lsp.jdtls")
end

M.use = function(use)
  use({
    "mfussenegger/nvim-jdtls",
    config = setup,
  })
end

return M
