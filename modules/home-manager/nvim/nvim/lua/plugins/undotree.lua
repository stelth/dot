local M = {}

local setup = function()
  local map = {
    u = { "<cmd>UndotreeToggle<CR>", "Undotree" },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "mbbill/undotree",
    config = setup,
  })
end

return M
