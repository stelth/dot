local M = {}

local setup = function()
  local trouble = require("trouble.providers.telescope")
  local telescope = require("telescope")

  telescope.setup({
    extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true } },
    defaults = {
      mappings = { i = { ["<c-t>"] = trouble.open_with_trouble } },
      prompt_prefix = " ",
      selection_caret = " ",
      winblend = 10,
      layout_config = {
        width = 0.7,
      },
    },
  })

  telescope.load_extension("fzy_native")
  telescope.load_extension("z")
  telescope.load_extension("zoxide")
end

function M.use(use)
  use({
    opt = true,
    "nvim-telescope/telescope.nvim",
    config = setup,
    cmd = { "Telescope" },
    module = "telescope",
    wants = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-z.nvim",
      "telescope-fzy-native.nvim",
      "telescope-project.nvim",
      "trouble.nvim",
      "telescope-symbols.nvim",
      "telescope-zoxide",
    },
    requires = {
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "jvgrootveld/telescope-zoxide",
    },
  })
end

return M
