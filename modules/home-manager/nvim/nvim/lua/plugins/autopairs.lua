local M = {}

local setup = function()
  require("nvim-autopairs").setup({
    map_bs = false,
  })
end

M.use = function(use)
  use({
    "windwp/nvim-autopairs",
    event = "BufReadPre",
    module = "nvim-autopairs",
    module_pattern = "nvim-autopairs.*",
    config = setup,
  })
end

return M
