vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file, { desc = "Add file to harpoon" })

vim.keymap.set("n", "<C-e>", require("harpoon.ui").toggle_quick_menu, { desc = "Harpoon quick menu" })

vim.keymap.set("n", "<leader>tc", require("harpoon.cmd-ui").toggle_quick_menu, {
  desc = "Harpoon command quick menu",
})

local keyToFileId = {
  ["<C-h>"] = 1,
  ["<C-t>"] = 2,
  ["<C-n>"] = 3,
  ["<C-s>"] = 4,
}

for key, fileId in pairs(keyToFileId) do
  vim.keymap.set("n", key, function()
    require("harpoon.ui").nav_file(fileId)
  end, { desc = "Go to harpoon file " .. tostring(fileId) })
end

local keyToTmuxWindowByNumber = {
  ["<C-G>"] = 1,
  ["<C-C>"] = 2,
  ["<C-R>"] = 3,
  ["<C-L>"] = 4,
}

for key, windowNumber in pairs(keyToTmuxWindowByNumber) do
  vim.keymap.set("n", key, function()
    require("harpoon.tmux").gotoTerminal(windowNumber)
  end, { desc = "Go to tmux window " .. tostring(windowNumber) })
end
