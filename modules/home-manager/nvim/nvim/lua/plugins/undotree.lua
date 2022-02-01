local M = {}

local setup = function()
  vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Undotree" })
end

M.use = function(use)
  use({
    "mbbill/undotree",
    config = setup,
  })
end

return M
