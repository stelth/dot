vim.keymap.set("n", ":", function()
  require("fine-cmdline").open({ default_value = "" })
end, { desc = "Floating Cmd Line" })

vim.keymap.set("v", ":", ":<C-u>FineCmdline '<,'><CR>", {
  desc = "Fine Command Line",
})
