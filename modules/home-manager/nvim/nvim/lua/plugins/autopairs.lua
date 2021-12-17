local M = {}

local setup = function()
  require("nvim-autopairs").setup({})
end

M.use = function(use)
  use({
    "windwp/nvim-autopairs",
    module = "nvim-autopairs",
    module_pattern = { "nvim-autopairs.*", "nvim-autopairs.*.*" },
    config = setup,
  })
end

return M
