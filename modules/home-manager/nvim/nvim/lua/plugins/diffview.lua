local M = {}

local setup = function()
  require("diffview").setup({})

  local map = {
    g = {
      d = { "<cmd>DiffviewOpen<CR>", "Diff View" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "sindrets/diffview.nvim",
    config = setup,
  })
end

return M
