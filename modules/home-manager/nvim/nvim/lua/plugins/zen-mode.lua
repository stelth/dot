local M = {}

local setup = function()
  require("zen-mode").setup({
    plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
  })

  local map = {
    Z = { "<cmd>lua require('zen-mode').reset()<CR>", "Reset Zen Mode" },
    z = { "<cmd>ZenMode<CR>", "Zen Mode" },
  }

  require("which-key").register(map, { prefix = "<leadere>" })
end

M.use = function(use)
  use({
    "folke/zen-mode.nvim",
    config = setup,
  })
end

return M
