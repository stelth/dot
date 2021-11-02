local M = {}

M.on_attach = function(client, bufnr)
  require("lsp.formatting").setup(client, bufnr)
  require("lsp.keys").setup(client, bufnr)
  require("lsp.highlighting").setup(client)
end

return M
