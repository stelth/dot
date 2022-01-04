local M = {}

local setup = function()
  local map = {
    o = {
      g = { "<cmd>Glow<CR>", "Glow" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "npxbr/glow.nvim",
    config = setup,
  })
end

return M
