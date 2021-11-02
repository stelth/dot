local M = {}

function M.use(use)
  use({
    "plasticboy/vim-markdown",
    opt = true,
    requires = "godlygeek/tabular",
    ft = "markdown",
  })
end

return M
