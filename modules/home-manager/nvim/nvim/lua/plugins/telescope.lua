local M = {}

local do_keymaps = function()
  local map = {
    g = {
      c = { "<cmd>Telescope git_commits<CR>", "Commits" },
      b = { "<cmd>Telescope git_branches<CR>", "Branches" },
      s = { "<cmd>Telescope git_status<CR>", "Status" },
    },
    h = {
      t = { "<cmd>Telescope builtin<CR>", "Builtins" },
      h = { "<cmd>Telescope help_tags<CR>", "Help" },
      m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
      k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
      s = { "<cmd>Telescope highlights<CR>", "Highlights" },
      f = { "<cmd>Telescope filetypes<CR>", "Filetypes" },
      o = { "<cmd>Telescope vim_options<CR>", "Vim Options" },
      a = { "<cmd>Telescope autocommands<CR>", "Autocommands" },
    },
    s = {
      g = { "<cmd>Telescope live_grep<CR>", "Grep" },
      b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Current Buffer" },
      h = { "<cmd>Telescope command_history<CR>", "Command History" },
      m = { "<cmd>Telescope marks<CR>", "Marks" },
    },
    f = {
      f = { "<cmd>Telescope find_files<CR>", "Find File" },
      r = { "<cmd>Telescope oldfiles<CR>", "Recently Used" },
      z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
    },
    ["."] = { "<cmd>Telescope file_browser<CR>", "File Browser" },
    [","] = { "<cmd>Telescope buffers show_all_buffers=true<CR>", "Find Buffer" },
    ["/"] = { "<cmd>Telescope live_grep<CR>", "Grep" },
    [":"] = { "<cmd>Telescope command_history<CR>", "Command History" },
  }
  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("TelescopeKeyMaps", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

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

M.use = function(use)
  use({
    "nvim-telescope/telescope.nvim",
    config = setup,
    event = "BufReadPre",
    requires = {
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "jvgrootveld/telescope-zoxide",
      "folke/trouble.nvim",
    },
  })
end

return M
