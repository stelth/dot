local M = {}

local setup = function()
  require("nvim-autopairs").setup({
    enable_check_bracket_line = false,
  })
end

M.use = function(use)
  use({
    "windwp/nvim-autopairs",
    config = setup,
  })
end

return M
