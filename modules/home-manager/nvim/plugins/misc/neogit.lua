require("neogit").setup({})

vim.keymap.set("n", "<leader>gs", require("neogit").open, {
  desc = "Neogit",
})

vim.keymap.set("n", "<leader>ga", function()
  os.execute("git fetch --all")
end, { desc = "Git fetch all" })
