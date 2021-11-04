local M = {}

local do_keymaps = function()
  local map = {
    x = {
      t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
      T = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("au").group("TodoKeyMaps", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

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
