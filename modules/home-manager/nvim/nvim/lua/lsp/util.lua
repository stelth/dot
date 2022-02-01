local M = {}

M.on_attach = function(client, bufnr)
  require("lsp.formatting").setup(client, bufnr)
  require("lsp.keys").setup(client, bufnr)
end

return M
