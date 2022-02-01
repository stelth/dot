local M = {}

local setup = function()
  vim.keymap.set("n", "<leader>og", ":Glow<CR>", { desc = "Glow" })
end

M.use = function(use)
  use({
    "npxbr/glow.nvim",
    config = setup,
  })
end

return M
