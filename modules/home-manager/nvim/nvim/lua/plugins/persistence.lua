local M = {}

local do_keymaps = function()
  local map = {
    q = {
      s = { "<cmd>lua require('persistence').load()<CR>", "Load Session" },
      l = { "<cmd>lua require('persistence').load({last = true})<CR>", "Load Last Session" },
      d = { "<cmd>lua require('persistence').stop()<CR>", "End Session" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("au").group("PersistenceKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("persistence").setup()
end

M.use = function(use)
  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = setup,
  })
end

return M
