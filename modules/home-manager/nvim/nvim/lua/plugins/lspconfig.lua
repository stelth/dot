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
    requires = {
      { "jose-elias-alvarez/null-ls.nvim", module = "null-ls" },
      { "folke/lua-dev.nvim", module = "lua-dev" },
    },
  })
end

return M
