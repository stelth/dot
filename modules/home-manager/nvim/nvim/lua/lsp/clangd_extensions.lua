local M = {}

M.setup = function()
  require("clangd_extensions").setup({
    server = require("lsp.util").setup({
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
      },
    }),
  })
end

return M
