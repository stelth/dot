local M = {}

local setup = function()
  require("todo-comments").setup({
    keywords = {
      TODO = {
        alt = { "WIP" },
      },
    },
  })
end

function M.use(use)
  use({
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = setup,
  })
end

return M
