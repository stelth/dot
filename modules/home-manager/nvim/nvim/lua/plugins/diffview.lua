local M = {}

local setup = function()
  require("diffview").setup({})

  vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Diff View" })
end

M.use = function(use)
  use({
    "sindrets/diffview.nvim",
    config = setup,
  })
end

return M
