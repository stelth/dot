local M = {}

local setup = function()
  vim.api.nvim_set_keymap("n", "<leader>hpp", ":PackerSync<CR>", { desc = "Packer sync" })
  vim.api.nvim_set_keymap("n", "<leader>hps", ":PackerStatus<CR>", { desc = "Packer status" })
  vim.api.nvim_set_keymap("n", "<leader>hpi", ":PackerInstall<CR>", { desc = "Packer install" })
  vim.api.nvim_set_keymap("n", "<leader>hpc", ":PackerCompile<CR>", { desc = "Packer compile" })
end

M.use = function(use)
  use({
    "wbthomason/packer.nvim",
    config = setup,
  })
end

return M
