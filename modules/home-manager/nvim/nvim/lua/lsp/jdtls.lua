require("jdtls").start_or_attach({
  cmd = { "jdt-language-server" },
  on_attach = require("lsp.util").on_attach,
})
