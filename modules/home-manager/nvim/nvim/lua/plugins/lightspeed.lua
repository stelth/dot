local M = {}

local setup = function()
  require("lightspeed").setup({
    repeat_ft_with_target_char = true,
  })
end

M.use = function(use)
  use({
    "ggandor/lightspeed.nvim",
    keys = { "s", "S", "f", "F", "t", "T" },
    config = setup,
  })
end

return M
