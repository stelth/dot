local M = {}

local do_keymaps = function()
  local map = {
    o = {
      g = { "<cmd>Glow<CR>", "Glow" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("GlowKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function() end

M.use = function(use)
  use({
    "npxbr/glow.nvim",
    cmd = "Glow",
    config = setup,
  })
end

return M
