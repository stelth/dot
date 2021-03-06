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

local keyToFileId = {
  ["<C-h>"] = 1,
  ["<C-t>"] = 2,
  ["<C-n>"] = 3,
  ["<C-s>"] = 4,
}

for key, fileId in pairs(keyToFileId) do
  vim.keymap.set("n", key, "", {
    callback = function()
      require("harpoon.ui").nav_file(fileId)
    end,
    desc = "Go to harpoon file " .. tostring(fileId),
  })
end

local keyToTmuxWindowByNumber = {
  ["<C-m>"] = 1,
  ["<C-w>"] = 2,
  ["<C-v>"] = 3,
  ["<C-z>"] = 4,
}

for key, windowNumber in pairs(keyToTmuxWindowByNumber) do
  vim.keymap.set("n", key, "", {
    callback = function()
      require("harpoon.tmux").gotoTerminal(windowNumber)
    end,
    desc = "Go to tmux window " .. tostring(windowNumber),
  })
end
