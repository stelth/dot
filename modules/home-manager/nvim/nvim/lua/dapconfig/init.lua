require("dapui").setup({
  sidebar = {
    size = 55,
    position = "left",
  },
  tray = {
    size = 15,
  },
  floating = {
    max_width = 0.9,
    max_height = 0.5,
    border = vim.g.border_chars,
  },
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })

require("dapconfig.python")
require("dapconfig.cpp")

require("nvim-dap-virtual-text").setup()
