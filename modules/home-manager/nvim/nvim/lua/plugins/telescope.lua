local M = {}

local util = require("util")
-- Git mappings
util.nnoremap("<leader>gc", ":Telescope git_commits<CR>")
util.nnoremap("<leader>gb", ":Telescope git_branches<CR>")
util.nnoremap("<leader>gs", ":Telescope git_status<CR>")

-- Help mappings
util.nnoremap("<leader>ht", ":Telescope builtin<CR>")
util.nnoremap("<leader>hh", ":Telescope help_tags<CR>")
util.nnoremap("<leader>hm", ":Telescope man_pages<CR>")
util.nnoremap("<leader>hk", ":Telescope keymaps<CR>")
util.nnoremap("<leader>hs", ":Telescope highlights<CR>")
util.nnoremap("<leader>hf", ":Telescope filetypes<CR>")
util.nnoremap("<leader>ho", ":Telescope vim_options<CR>")
util.nnoremap("<leader>ha", ":Telescope autocommands<CR>")

-- Search mappings
util.nnoremap("<leader>sg", ":Telescope live_grep<CR>")
util.nnoremap("<leader>sb", ":Telescope current_buffer_fuzzy_find<CR>")
util.nnoremap("<leader>sh", ":Telescope command_history<CR>")
util.nnoremap("<leader>sm", ":Telescope marks<CR>")

-- Find file mappings
util.nnoremap("<leader>ff", ":Telescope find_files<CR>")
util.nnoremap("<leader>fr", ":Telescope oldfiles<CR>")
util.nnoremap("<leader>fz", ":Telescope zoxide list<CR>")

-- General mappings
util.nnoremap("<leader>.", ":Telescope file_browser<CR>")
util.nnoremap("<leader>,", ":Telescope buffers show_all_buffers=true<CR>")
util.nnoremap("<leader>/", ":Telescope live_grep<CR>")
util.nnoremap("<leader>:", ":Telescope command_history<CR>")

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
    cmd = { "Telescope" },
    module = "telescope",
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
