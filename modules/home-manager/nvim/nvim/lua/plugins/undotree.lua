local M = {}

M.setup = function()
  vim.keymap.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", {
    desc = "Undo Tree",
  })
end

return M
