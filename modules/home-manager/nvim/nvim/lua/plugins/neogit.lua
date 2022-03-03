local M = {}

M.setup = function()
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

  vim.keymap.set("n", "<leader>g", "", {
    callback = require("neogit").open,
    desc = "NeoGit",
  })
end

return M
