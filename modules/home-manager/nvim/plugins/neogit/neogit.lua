require("neogit").setup({})

vim.keymap.set("n", "<leader>gs", "", {
  callback = require("neogit").open,
  desc = "Neogit",
})

vim.keymap.set("n", "<leader>ga", "", {
  callback = function()
    os.execute("git fetch --all")
  end,
  desc = "Git fetch all",
})
