require("fidget").setup({
  window = {
    relative = "editor",
  },
})

vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })
