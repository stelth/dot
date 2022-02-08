local M = {}

M.setup = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  require("clangd_extensions").setup({
    server = {
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
      },
      capabilities = capabilities,
      on_attach = require("lsp.util").on_attach,
      flags = {
        debounce_text_changes = 150,
      },
    },
  })
end

return M
