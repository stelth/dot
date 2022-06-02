require("refactoring").setup({})

vim.keymap.set({ "v", "n" }, "<leader>rr", "", {
  callback = function()
    require("refactoring").select_refactor()
  end,
  desc = "Refactor: Get available refactors",
})

vim.keymap.set("v", "<leader>ree", "", {
  callback = function()
    require("refactoring").refactor(106)
  end,
  desc = "Refactor: Extract function",
})

vim.keymap.set("n", "<leader>ri", "", {
  callback = function()
    require("refactoring").refactor(123)
  end,
  desc = "Refactor: Inline variable",
})

vim.keymap.set("v", "<leader>rev", "", {
  callback = function()
    require("refactoring").refactor("extract_var")
  end,
  desc = "Refactor: Extract variable",
})

vim.keymap.set("n", "<leader>dg", "", {
  callback = function()
    require("refactoring").debug.printf({ below = false })
  end,
  desc = "Refactor: Printf above",
})

vim.keymap.set("n", "<leader>dm", "", {
  callback = function()
    require("refactoring").debug.printf({ below = true })
  end,
  desc = "Refactor: Printf below",
})

vim.keymap.set("n", "<leader>df", "", {
  callback = function()
    require("refactoring").debug.print_var({ below = false })
  end,
  desc = "Refactor: Print var above",
})

vim.keymap.set("n", "<leader>db", "", {
  callback = function()
    require("refactoring").debug.print_var({ below = true })
  end,
  desc = "Refactor: Print var below",
})
