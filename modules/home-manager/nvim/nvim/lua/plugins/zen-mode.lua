local M = {}

local do_keymaps = function()
  local map = {
    Z = { "<cmd>lua require('zen-mode').reset()<CR>", "Reset Zen Mode" },
    z = { "<cmd>ZenMode<CR>", "Zen Mode" },
  }

  require("which-key").register(map, { prefix = "<leadere>" })
end

require("au").group("ZenModeKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("zen-mode").setup({
    plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
  })
end

M.use = function(use)
  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    requires = { "folke/twilight.nvim" },
    config = setup,
  })
end

return M
