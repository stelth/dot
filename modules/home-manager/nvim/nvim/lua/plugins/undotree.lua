local M = {}

local setup = function()
  vim.api.nvim_set_keymap("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Undotree" })
end

M.use = function(use)
  use({
    "mbbill/undotree",
    config = setup,
  })
end

return M
