local M = {}

local setup = function()
  require("project_nvim").setup({})
end

M.use = function(use)
  use({
    "ahmedkhalf/project.nvim",
    event = "BufReadPre",
    config = setup,
  })
end

return M
