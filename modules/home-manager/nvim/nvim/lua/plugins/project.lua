local M = {}

M.setup = function()
  require("project_nvim").setup({})

  vim.keymap.set("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Find project" })
end

return M
