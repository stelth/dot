local M = {}

local setup = function()
  require("nvim-web-devicons").setup({ default = true })
end

M.use = function(use)
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = setup,
  })
end

return M
