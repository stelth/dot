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
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
    },
  })
end

return M
