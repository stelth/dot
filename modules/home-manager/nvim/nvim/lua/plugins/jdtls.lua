local M = {}

local setup = function()
  require("lsp.jdtls")
end

M.use = function(use)
  use({
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = setup,
  })
end

return M
