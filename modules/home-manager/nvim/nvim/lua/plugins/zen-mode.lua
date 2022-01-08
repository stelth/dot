local M = {}

local setup = function()
  require("zen-mode").setup({
    plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
  })

  vim.api.nvim_set_keymap("n", "<leader>Z", "", {
    callback = require("zen-mode").reset,
    desc = "Reset zen mode",
  })
  vim.api.nvim_set_keymap("n", "<leader>z", ":ZenMode<CR>", { desc = "Zen Mode" })
end

M.use = function(use)
  use({
    "folke/zen-mode.nvim",
    config = setup,
  })
end

return M
