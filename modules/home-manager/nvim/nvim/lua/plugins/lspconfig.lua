local M = {}

local setup = function()
  require("lsp")
end

function M.use(use)
  use({
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    config = setup,
  })
end

return M
