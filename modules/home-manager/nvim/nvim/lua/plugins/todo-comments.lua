local M = {}

local setup = function()
  require("todo-comments").setup({
    keywords = {
      TODO = {
        alt = { "WIP" },
      },
    },
  })

  vim.api.nvim_set_keymap("n", "<leader>xt", ":TodoTrouble<CR>", { desc = "Todo Trouble" })
  vim.api.nvim_set_keymap("n", "<leader>xT", ":TodoTelescope<CR>", { desc = "Todo Telescope" })
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
