local M = {}

local setup = function()
  require("neogit").setup({
    kind = "split",
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  })

  local map = {
    g = {
      g = { "<cmd>Neogit kind=split<CR>", "Neogit" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = setup,
  })
end

return M
