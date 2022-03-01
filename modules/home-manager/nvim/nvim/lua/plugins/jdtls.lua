local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd("Filetype", {
    pattern = "java",
    callback = require("lsp.jdtls").setup,
  })
end

return M
