local M = {}

local setup = function()
  require("fidget").setup({
    text = {
      spinner = "dots_pulse",
    },
  })
end

M.use = function(use)
  use({
    "j-hui/fidget.nvim",
    config = setup,
  })
end

return M
