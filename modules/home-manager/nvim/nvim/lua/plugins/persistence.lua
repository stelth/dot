local M = {}

local setup = function()
  require("persistence").setup()

  vim.api.nvim_set_keymap("n", "<leader>qs", "", {
    callback = require("persistence").load,
    desc = "Load session",
  })
  vim.api.nvim_set_keymap("n", "<leader>ql", "", {
    callback = function()
      require("persistence").load({ last = true })
    end,
    desc = "Load last session",
  })
  vim.api.nvim_set_keymap("n", "<leader>qd", "", {
    callback = require("persistence").stop,
    desc = "End session",
  })
end

M.use = function(use)
  use({
    "folke/persistence.nvim",
    config = setup,
  })
end

return M
