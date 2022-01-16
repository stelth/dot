local M = {}

local setup = function()
  require("onedark").setup({
    dark_float = false,
    dark_sidebar = false,
    highlight_linenumber = true,
    hide_inactive_statusline = true,
  })
end

M.use = function(use)
  use({
    "ful1e5/onedark.nvim",
    config = setup,
  })
end

return M
