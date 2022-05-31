vim.keymap.set("n", "<leader>a", "", {
  callback = require("harpoon.mark").add_file,
  desc = "Add file to harpoon",
})

vim.keymap.set("n", "<C-e>", "", {
  callback = require("harpoon.ui").toggle_quick_menu,
  desc = "Harpoon quick menu",
})

vim.keymap.set("n", "<leader>tc", "", {
  callback = require("harpoon.cmd-ui").toggle_quick_menu,
  desc = "Harpoon command quick menu",
})

vim.keymap.set("n", "<C-j>", "", {
  callback = function()
    require("harpoon.ui").nav_file(1)
  end,
  desc = "First harpoon file",
})

vim.keymap.set("n", "<C-k>", "", {
  callback = function()
    require("harpoon.ui").nav_file(2)
  end,
  desc = "Second harpoon file",
})

vim.keymap.set("n", "<C-l>", "", {
  callback = function()
    require("harpoon.ui").nav_file(3)
  end,
  desc = "Third harpoon file",
})

vim.keymap.set("n", "<C-;>", "", {
  callback = function()
    require("harpoon.ui").nav_file(4)
  end,
  desc = "Fourth harpoon file",
})
