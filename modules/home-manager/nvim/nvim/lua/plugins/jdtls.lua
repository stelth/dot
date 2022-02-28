local M = {}

M.setup = function()
  vim.api.nvim_create_autocmd({
    event = "FileType",
    pattern = "java",
    callback = function()
      require("lsp.jdtls")
    end,
  })
end

return M
