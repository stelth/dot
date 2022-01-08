local M = {}

local setup = function()
  vim.api.nvim_set_keymap("n", "<leader>og", ":Glow<CR>", { desc = "Glow" })
end

M.use = function(use)
  use({
    "npxbr/glow.nvim",
    config = setup,
  })
end

return M
