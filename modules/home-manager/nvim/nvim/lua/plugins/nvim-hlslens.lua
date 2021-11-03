local M = {}

function M.use(use)
  use({
    "kevinhwang91/nvim-hlslens",
    event = "VimEnter",
  })
end

return M
