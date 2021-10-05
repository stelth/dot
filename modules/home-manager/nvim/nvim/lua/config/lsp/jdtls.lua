require("jdtls").start_or_attach({
  cmd = { "jdt-language-server" },
  on_attach = require("config.lsp.util").on_attach,
})
