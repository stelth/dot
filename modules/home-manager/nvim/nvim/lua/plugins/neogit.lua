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

  vim.api.nvim_set_keymap("n", "<leader>gg", ":Neogit kind=split<CR>", { desc = "Neogit" })
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
