local M = {}

local setup = function()
  require("lsp")
end

M.use = function(use)
  use({
    "neovim/nvim-lspconfig",
    config = setup,
    requires = {
      { "jose-elias-alvarez/null-ls.nvim" },
      { "folke/lua-dev.nvim" },
      { "p00f/clangd_extensions.nvim" },
    },
  })
end

return M
