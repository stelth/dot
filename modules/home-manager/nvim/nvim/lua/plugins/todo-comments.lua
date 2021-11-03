local M = {}

local util = require("util")
util.nnoremap("<leader>xt", ":TodoTrouble<CR>")
util.nnoremap("<leader>xT", ":TodoTelescope<CR>")

local setup = function()
  require("todo-comments").setup({
    keywords = {
      TODO = {
        alt = { "WIP" },
      },
    },
  })
end

M.use = function(use)
  use({
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = setup,
  })
end

return M
