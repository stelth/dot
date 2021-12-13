local M = {}

local setup = function()
  require("lightspeed").setup({})
end

M.use = function(use)
  use({
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = setup,
  })
end

return M
