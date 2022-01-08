local M = {}

local setup = function()
  require("cmake").setup({
    configure_args = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1", "-G", "Ninja" },
    dap_open_command = require("dapui").open,
  })

  require("telescope").load_extension("cmake")

  vim.api.nvim_set_keymap("n", "<leader>cbba", ":CMake build_all<CR>", { desc = "Build all" })
  vim.api.nvim_set_keymap("n", "<leader>cbbd", ":CMake build_and_debug<CR>", { desc = "Build and debug" })
  vim.api.nvim_set_keymap("n", "<leader>cbbr", ":CMake build_and_run<CR>", { desc = "Build and run" })
  vim.api.nvim_set_keymap("n", "<leader>cbbt", ":CMake build<CR>", { desc = "Build target" })
  vim.api.nvim_set_keymap("n", "<leader>cbcc", ":CMake clear_cache<CR>", { desc = "Clear cache" })
  vim.api.nvim_set_keymap("n", "<leader>cbcp", ":CMake configure<CR>", { desc = "Configure project" })
  vim.api.nvim_set_keymap("n", "<leader>cbd", ":CMake debug<CR>", { desc = "Debug target" })
  vim.api.nvim_set_keymap("n", "<leader>cbk", ":CMake cancel<CR>", { desc = "Cancel build" })
  vim.api.nvim_set_keymap("n", "<leader>cbr", ":CMake run<CR>", { desc = "Run target" })
  vim.api.nvim_set_keymap("n", "<leader>cbsa", ":CMake set_target_args<CR>", { desc = "Set arguments" })
  vim.api.nvim_set_keymap("n", "<leader>cbsb", ":Telescope cmake select_build_type<CR>", { desc = "Select build type" })
  vim.api.nvim_set_keymap("n", "<leader>cbst", ":Telescope cmake select_target<CR>", { desc = "Select target" })
end

M.use = function(use)
  use({
    "Shatur/neovim-cmake",
    config = setup,
    requires = {
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap",
    },
  })
end

return M
