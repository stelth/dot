local M = {}

local setup = function()
  vim.keymap.set("n", "<leader>hpp", ":PackerSync<CR>", { desc = "Packer sync" })
  vim.keymap.set("n", "<leader>hps", ":PackerStatus<CR>", { desc = "Packer status" })
  vim.keymap.set("n", "<leader>hpi", ":PackerInstall<CR>", { desc = "Packer install" })
  vim.keymap.set("n", "<leader>hpc", ":PackerCompile<CR>", { desc = "Packer compile" })
end

M.use = function(use)
  use({
    "wbthomason/packer.nvim",
    config = setup,
  })
end

return M
