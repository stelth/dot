local M = {}

local setup = function()
  require("dapconfig")
end

M.use = function(use)
  use({
    "mfussenegger/nvim-dap",
    config = setup,
    requires = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
    },
  })
end

return M
