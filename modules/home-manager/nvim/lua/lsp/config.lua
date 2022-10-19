local M = {}

M.on_attach = function(client, bufnr)
  require("inlay-hints").on_attach(client, bufnr)
  require("lsp.formatting").format_callback(client, bufnr)
  require("lsp.keymaps").keymap_callback(client, bufnr)
end

M.make_config = function(customConfig)
  local default_config = {
    on_attach = M.on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    flags = {
      debounce_text_changes = 150,
    },
  }

  return vim.tbl_deep_extend("force", default_config, customConfig)
end

return M
