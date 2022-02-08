local M = {}

M.make_config = function(config)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  local on_attach = function(client, bufnr)
    require("lsp.formatting").setup(client, bufnr)
    require("lsp.keys").setup(client, bufnr)
  end

  local default_config = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }

  local new_config = vim.tbl_deep_extend("force", default_config, config)

  return new_config
end

return M
