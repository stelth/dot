local M = {}

M.setup = function(config)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local on_attach = function(client, bufnr)
    require("lsp.formatting").setup(client, bufnr)
    require("lsp.keys").setup(client, bufnr)
  end

  local new_config = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config)

  return new_config
end

return M
