require("neogit").setup({})

vim.keymap.set("n", "<leader>gs", "", {
  callback = require("neogit").open,
  desc = "Neogit",
})

vim.keymap.set("n", "<leader>ga", "<cmd>!git fetch --all<CR>", {
  desc = "Git fetch all",
})
