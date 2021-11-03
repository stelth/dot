local M = {}

local setup = function()
  require("zen-mode").setup({
    plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
  })
end

function M.use(use)
  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opt = true,
    wants = "twilight.nvim",
    requires = { "folke/twilight.nvim" },
    config = setup,
  })
end

return M
