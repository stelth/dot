local M = {}

local setup = function()
  require("nvim-autopairs").setup({})
end

function M.use(use)
  use({
    "windwp/nvim-autopairs",
    event = "BufReadPre",
    config = setup,
  })
end

return M
