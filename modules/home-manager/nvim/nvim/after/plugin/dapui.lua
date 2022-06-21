local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

dapui.setup({
  layouts = {
    {
      elements = {
        "scopes",
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 10,
      position = "bottom",
    },
  },
})

daptext.setup()

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

vim.keymap.set("n", "<leader>5", "", {
  callback = dap.continue,
  desc = "DAP Continue",
})

vim.keymap.set("n", "<leader>6", "", {
  callback = function()
    dapui.close()
    dap.terminate()
    daptext.refresh()
  end,
  desc = "DAP Close",
})

vim.keymap.set("n", "<Up>", "", {
  callback = dap.continue,
  desc = "DAP Continue",
})

vim.keymap.set("n", "<Down>", "", {
  callback = dap.step_over,
  desc = "DAP Step Over",
})

vim.keymap.set("n", "<Right>", "", {
  callback = dap.step_into,
  desc = "DAP Step Into",
})

vim.keymap.set("n", "<Left>", "", {
  callback = dap.step_out,
  desc = "DAP Step Out",
})

vim.keymap.set("n", "<leader>b", "", {
  callback = dap.toggle_breakpoint,
  desc = "DAP Toggle Breakpoint",
})

vim.keymap.set("n", "<leader>B", "", {
  callback = function()
    dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
  end,
  desc = "DAP Conditional Breakpoint",
})

vim.keymap.set("n", "<leader>rc", "", {
  callback = dap.run_to_cursor,
  desc = "DAP Run To Cursor",
})
