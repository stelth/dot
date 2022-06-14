local telescope = require("telescope")

telescope.setup({
  extensions = {
    fzy_native = { override_generic_sorter = false, override_file_sorter = true },
  },
  defaults = {
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    prompt_prefix = " > ",
    color_devicons = true,

    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-q>"] = require("telescope.actions").send_to_qflist,
      },
    },
  },
})

telescope.load_extension("fzy_native")
telescope.load_extension("notify")

vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "Git commits" })
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", { desc = "Git status" })

vim.keymap.set("n", "<leader>ht", ":Telescope builtin<CR>", { desc = "Builtins" })
vim.keymap.set("n", "<leader>hh", ":Telescope help_tags<CR>", { desc = "Help" })
vim.keymap.set("n", "<leader>hm", ":Telescope man_pages<CR>", { desc = "Man pages" })
vim.keymap.set("n", "<leader>hk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>hs", ":Telescope highlights<CR>", { desc = "Highlights" })
vim.keymap.set("n", "<leader>hf", ":Telescope filetypes<CR>", { desc = "Filetypes" })
vim.keymap.set("n", "<leader>ho", ":Telescope vim_options<CR>", { desc = "Vim options" })
vim.keymap.set("n", "<leader>ha", ":Telescope autocommands<CR>", { desc = "Autocommands" })

vim.keymap.set("n", "<leader>sg", ":Telescope live_grep<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>sb", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Search current buffer" })
vim.keymap.set("n", "<leader>sh", ":Telescope command_history<CR>", { desc = "Command history" })
vim.keymap.set("n", "<leader>sm", ":Telescope marks<CR>", { desc = "Marks" })

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find file" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recently used" })

vim.keymap.set("n", "<leader>,", ":Telescope buffers show_all_buffers=true<CR>", { desc = "Find buffer" })
vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>", { desc = "Grep" })
vim.keymap.set("n", "<leader>:", ":Telescope command_history<CR>", { desc = "Command history" })
