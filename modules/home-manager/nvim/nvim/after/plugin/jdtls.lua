local setup = function()
  require("jdtls").start_or_attach({
    cmd = { "jdt-language-server" },
    on_attach = require("lsp.util").on_attach,
  })
end

vim.api.nvim_create_autocmd("Filetype", {
  pattern = "java",
  callback = setup,
})
