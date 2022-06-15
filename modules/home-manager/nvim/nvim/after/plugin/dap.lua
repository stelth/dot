require("dapui").setup({
  sidebar = {
    size = 80,
    position = "left",
  },
  tray = {
    size = 30,
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

local dap = require("dap")

dap.adapters.cpp = {
  type = "executable",
  attach = {
    pidProperty = "pid",
    pidSelect = "ask",
  },
  command = "lldb-vscode",
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
  },
  name = "lldb",
}

local lldb = function(command, ...)
  local config = {
    type = "cpp",
    name = command,
    request = "launch",
    program = command,
    args = { ... },
  }

  dap.run(config)
  dap.repl.open()
end

vim.keymap.set("n", "<leader>dbc", "", {
  callback = function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: "))
  end,
  desc = "Conditional breakpoint",
})
vim.keymap.set("n", "<leader>dbt", "", {
  callback = require("dap").toggle_breakpoint,
  desc = "Toggle breakpoint",
})
vim.keymap.set("n", "<leader>dbs", "", {
  callback = function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end,
  desc = "Breakpoint with message",
})
vim.keymap.set("n", "<leader>dc", "", {
  callback = require("dap").continue,
  desc = "Continue",
})
vim.keymap.set("n", "<leader>dd", "", {
  callback = function()
    lldb(vim.fn.input("Executable: "))
  end,
  desc = "Debug Application",
})
vim.keymap.set("n", "<leader>de", "", {
  callback = require("dapui").eval,
  desc = "Eval",
})
vim.keymap.set("n", "<leader>dp", "", {
  callback = require("dap").pause,
  desc = "Pause",
})
vim.keymap.set("n", "<leader>dq", "", {
  callback = function()
    require("dapui").close()
    require("dap").terminate()
    require("nvim-dap-virtual-text").refresh()
  end,
  desc = "Terminate",
})
vim.keymap.set("n", "<leader>dsi", "", {
  callback = require("dap").step_into,
  desc = "Step into",
})
vim.keymap.set("n", "<leader>dso", "", {
  callback = require("dap").step_out,
  desc = "Step out",
})
vim.keymap.set("n", "<leader>dsv", "", {
  callback = require("dap").step_over,
  desc = "Step over",
})
vim.keymap.set("n", "<leader>du", "", {
  callback = require("dapui").toggle,
  desc = "Toggle DAP UI",
})

require("nvim-dap-virtual-text").setup()
