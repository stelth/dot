local M = {}

local setup = function()
  require("todo-comments").setup({
    keywords = {
      TODO = {
        alt = { "WIP" },
      },
    },
  })

  local map = {
    x = {
      t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
      T = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "folke/todo-comments.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = setup,
  })
end

return M
