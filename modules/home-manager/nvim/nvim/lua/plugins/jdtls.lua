local M = {}

local setup = function()
  require("lsp.jdtls")
end

function M.use(use)
  use({
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = setup,
  })
end

return M
