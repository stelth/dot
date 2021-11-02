local M = {}

local setup = function()
  require("trouble").setup({ auto_open = false })
end

function M.use(use)
  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    requires = { "nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    config = setup,
  })
end

return M
