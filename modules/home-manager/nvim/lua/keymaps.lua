vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Toggle
local toggle = require("utils").toggle
vim.keymap.set("n", "<leader>ts", function()
  toggle("spell")
end, { desc = "Toggle Spell" })
vim.keymap.set("n", "<leader>tw", function()
  toggle("wrap")
end, { desc = "Toggle Wrap" })
vim.keymap.set("n", "<leader>tn", function()
  toggle("relativenumber", true)
  toggle("number")
end, { desc = "Toggle Line Numbers" })

vim.keymap.set("n", "<C-k>", vim.cmd.cnext)
vim.keymap.set("n", "<C-j>", vim.cmd.cprev)
vim.keymap.set("n", "<leader>k", vim.cmd.lnext)
vim.keymap.set("n", "<leader>j", vim.cmd.lprev)

vim.keymap.set("", "<ESC>", ":noh<ESC>")
