require("cmake").setup({
  configure_args = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1", "-G", "Ninja" },
  dap_open_command = require("dapui").open,
})

vim.keymap.set("n", "<leader>cbba", ":CMake build_all<CR>", { desc = "Build all" })
vim.keymap.set("n", "<leader>cbbd", ":CMake build_and_debug<CR>", { desc = "Build and debug" })
vim.keymap.set("n", "<leader>cbbr", ":CMake build_and_run<CR>", { desc = "Build and run" })
vim.keymap.set("n", "<leader>cbbt", ":CMake build<CR>", { desc = "Build target" })
vim.keymap.set("n", "<leader>cbcc", ":CMake clear_cache<CR>", { desc = "Clear cache" })
vim.keymap.set("n", "<leader>cbcp", ":CMake configure<CR>", { desc = "Configure project" })
vim.keymap.set("n", "<leader>cbd", ":CMake debug<CR>", { desc = "Debug target" })
vim.keymap.set("n", "<leader>cbk", ":CMake cancel<CR>", { desc = "Cancel build" })
vim.keymap.set("n", "<leader>cbr", ":CMake run<CR>", { desc = "Run target" })
vim.keymap.set("n", "<leader>cbsa", ":CMake set_target_args<CR>", { desc = "Set arguments" })
vim.keymap.set("n", "<leader>cbsb", ":CMake select_build_type<CR>", { desc = "Select build type" })
vim.keymap.set("n", "<leader>cbst", ":CMake select_target<CR>", { desc = "Select target" })
