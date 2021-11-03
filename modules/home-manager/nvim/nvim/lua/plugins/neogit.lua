local M = {}

local util = require("util")
util.nnoremap("<leader>gg", ":Neogit<CR>")

local setup = function()
  require("neogit").setup({
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
  })
end

M.use = function(use)
  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = setup,
  })
end

return M
