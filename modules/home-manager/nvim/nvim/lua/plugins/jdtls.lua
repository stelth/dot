local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd({
    event = "FileType",
    pattern = "java",
    callback = require("lsp.jdtls").setup,
  })
end

return M
