local M = {}

M.setup = function()
  require("clangd_extensions").setup({
    server = require("lsp.util").make_config({
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
