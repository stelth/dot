local M = {}

local setup = function()
  require("persistence").setup()

  local map = {
    q = {
      s = { "<cmd>lua require('persistence').load()<CR>", "Load Session" },
      l = { "<cmd>lua require('persistence').load({last = true})<CR>", "Load Last Session" },
      d = { "<cmd>lua require('persistence').stop()<CR>", "End Session" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "folke/persistence.nvim",
    config = setup,
  })
end

return M
