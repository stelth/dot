local M = {}

local setup = function()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      prompt_prefix = "❯ ",
      selection_caret = "❯ ",

      winblend = 0,

      layout_strategy = "horizontal",
      layout_config = {
        width = 0.95,
        height = 0.85,
        prompt_position = "bottom",

        horizontal = {
          preview_width = function(_, cols, _)
            if cols > 200 then
              return math.floor(cols * 0.4)
            else
              return math.floor(cols * 0.6)
            end
          end,
        },

        vertical = {
          width = 0.9,
          height = 0.95,
          preview_height = 0.5,
        },

        flex = {
          horizontal = {
            preview_width = 0.9,
          },
        },
      },

      selection_strategy = "reset",
      sorting_strategy = "descending",
      scroll_strategy = "cycle",
      color_devicons = true,

      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    },

    git_branches = {
      mappings = {
        i = {
          ["<C-a>"] = false,
        },
      },
    },

    extensions = {
      fzy_native = {
        override_generic_sorter = true,
        override_file_sorter = true,
      },
    },
  })

  telescope.load_extension("fzy_native")

  vim.api.nvim_set_keymap("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git commits" })
  vim.api.nvim_set_keymap("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git branches" })
  vim.api.nvim_set_keymap("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Git status" })

  vim.api.nvim_set_keymap("n", "<leader>ht", ":Telescope builtins<CR>", { desc = "Builtins" })
  vim.api.nvim_set_keymap("n", "<leader>hh", ":Telescope help_tags<CR>", { desc = "Help" })
  vim.api.nvim_set_keymap("n", "<leader>hm", ":Telescope man_pages<CR>", { desc = "Man pages" })
  vim.api.nvim_set_keymap("n", "<leader>hk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
  vim.api.nvim_set_keymap("n", "<leader>hs", ":Telescope highlights<CR>", { desc = "keymaps" })
  vim.api.nvim_set_keymap("n", "<leader>hf", ":Telescope filetypes<CR>", { desc = "Filetypes" })
  vim.api.nvim_set_keymap("n", "<leader>ho", ":Telescope vim_options<CR>", { desc = "Vim options" })
  vim.api.nvim_set_keymap("n", "<leader>ha", ":Telescope autocommands<CR>", { desc = "Autocommands" })

  vim.api.nvim_set_keymap("n", "<leader>sg", ":Telescope live_grep<CR>", { desc = "Grep" })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>sb",
    ":Telescope current_buffer_fuzzy_find<CR>",
    { desc = "Search current buffer" }
  )
  vim.api.nvim_set_keymap("n", "<leader>sh", ":Telescope command_history<CR>", { desc = "Command history" })
  vim.api.nvim_set_keymap("n", "<leader>sm", ":Telescope marks<CR>", { desc = "Marks" })

  vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find file" })
  vim.api.nvim_set_keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recently used" })
  vim.api.nvim_set_keymap("n", "<leader>fz", ":Telescope zoxide list<CR>", { desc = "Zoxide" })

  vim.api.nvim_set_keymap("n", "<leader>,", ":Telescope buffers show_all_buffers=true<CR>", { desc = "Find buffer" })
  vim.api.nvim_set_keymap("n", "<leader>/", ":Telescope live_grep<CR>", { desc = "Grep" })
  vim.api.nvim_set_keymap("n", "<leader>:", ":Telescope command_history<CR>", { desc = "Command history" })
end

M.use = function(use)
  use({
    "nvim-telescope/telescope.nvim",
    config = setup,
    requires = {
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
    },
  })
end

return M
