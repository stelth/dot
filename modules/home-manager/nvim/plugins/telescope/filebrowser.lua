require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<leader>fb", "", {
  callback = require("telescope").extensions.file_browser.file_browser,
  desc = "File Browser",
})
