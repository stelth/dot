local M = {}

local setup = function()
  require("wlsample.evil_line")
  require("wlfloatline").setup()
end

function M.use(use)
  use({
    "windwp/windline.nvim",
    event = "VimEnter",
    config = setup,
  })
end

return M
