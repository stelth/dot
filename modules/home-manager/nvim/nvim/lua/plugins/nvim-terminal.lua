local M = {}

local setup = function()
  require("terminal").setup()
end

function M.use(use)
  use({
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = setup,
  })
end

return M
