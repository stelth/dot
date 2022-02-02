local M = {}

local setup = function()
  require("yabs"):setup({
    languages = {
      haskell = {
        tasks = {
          run = {
            command = "cabal run",
            type = "shell",
          },
          build = {
            command = "cabal build",
            type = "shell",
          },
        },
      },
    },
  })

  vim.keymap.set("n", "<leader>pb", ":lua require('yabs'):run_task('build')<CR>", { desc = "Build Project" })
  vim.keymap.set("n", "<leader>pr", ":lua require('yabs'):run_task('run')<CR>", { desc = "Run Project" })
end

M.use = function(use)
  use({
    "pianocomposer321/yabs.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = setup,
  })
end

return M
