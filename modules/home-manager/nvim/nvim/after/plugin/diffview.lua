require("diffview").setup({})

vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Diff View" })
