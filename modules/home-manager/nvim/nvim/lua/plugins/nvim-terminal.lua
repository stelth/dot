local M = {}

local setup = function()
  require("terminal").setup()
end

M.use = function(use)
  use({
    "norcalli/nvim-terminal.lua",
    config = setup,
  })
end

return M
