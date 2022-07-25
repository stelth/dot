vim.keymap.set("n", "<leader>u", "", {
  callback = vim.cmd.UndotreeToggle,
  desc = "Undo Tree",
})
