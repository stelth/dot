local M = {}

local setup = function()
  require("cmake").setup({
    configure_args = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1", "-G", "Ninja" },
    dap_open_command = require("dapui").open,
  })

  require("telescope").load_extension("cmake")

  local map = {
    c = {
      b = {
        name = "+build",
        ["ba"] = { "<cmd>CMake build_all<CR>", "Build All" },
        ["bd"] = { "<cmd>CMake build_and_debug<CR>", "Build and Debug" },
        ["br"] = { "<cmd>CMake build_and_run<CR>", "Build and Run" },
        ["bt"] = { "<cmd>CMake build<CR>", "Build Target" },
        ["cc"] = { "<cmd>CMake clear_cache<CR>", "Clear Cache" },
        ["cp"] = { "<cmd>CMake configure<CR>", "Configure Project" },
        d = { "<cmd>CMake debug<CR>", "Debug" },
        k = { "<cmd>CMake cancel<CR>", "Cancel Build" },
        r = { "<cmd>CMake run<CR>", "Run" },
        ["sa"] = { "<cmd>CMake set_target_args<CR>", "Set arguments" },
        ["sb"] = { "<cmd>CMake select_build_type<CR>", "Select Build Type" },
        ["st"] = { "<cmd>Telescope cmake select_target<CR>", "Select Target" },
      },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
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
