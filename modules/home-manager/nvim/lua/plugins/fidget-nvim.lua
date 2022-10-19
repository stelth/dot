require("fidget").setup({
  text = {
    spinner = "dots",
  },
  window = {
    relative = "editor",
  },
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  command = "silent! FidgetClose",
})
