-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

local function lspSymbol(name, icon)
  vim.fn.sign_define("DiagnosticsSign" .. name, { text = icon, numhl = "DiagnosticDefault" .. name })
end

lspSymbol("Error", " ")
lspSymbol("Warn", " ")
lspSymbol("Hint", " ")
lspSymbol("Info", " ")
