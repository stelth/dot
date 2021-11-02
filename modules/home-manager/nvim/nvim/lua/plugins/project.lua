local M = {}

local setup = function()
  require("project_nvim").setup({})
end

function M.use(use)
  use({
    "ahmedkhalf/project.nvim",
    event = "BufReadPre",
    config = setup,
  })
end

return M
