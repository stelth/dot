local M = {}

local setup = function()
  vim.api.nvim_set_keymap("n", "<leader>bd", ":BDelete this<CR>", { desc = "Delete Buffer" })
end

M.use = function(use)
  use({
    "kazhala/close-buffers.nvim",
    config = setup,
  })
end

return M
