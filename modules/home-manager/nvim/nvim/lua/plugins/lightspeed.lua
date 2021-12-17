local M = {}

local setup = function()
  require("lightspeed").setup({})
end

M.use = function(use)
  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = setup,
  })
end

return M
