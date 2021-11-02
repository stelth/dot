local M = {}

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

function M.use(use)
  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = setup,
  })
end

return M
