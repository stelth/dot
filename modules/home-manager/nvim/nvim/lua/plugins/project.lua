local M = {}

local setup = function()
  require("project_nvim").setup({})

  require("telescope").load_extension("projects")
end

M.use = function(use)
  use({
    "ahmedkhalf/project.nvim",
    config = setup,
  })
end

return M
