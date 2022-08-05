require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<leader>fb", require("telescope").extensions.file_browser.file_browser, {
  desc = "File Browser",
})
