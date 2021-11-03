local M = {}

local setup = function()
  require("lsp")
end

M.use = function(use)
  use({
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    config = setup,
  })
end

return M
