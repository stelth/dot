local dap = require("dap")
local dapui = require("dapui")

dap.adapters.lldb = {
  type = "executable",
  attach = {
    pidProperty = "pid",
    pidSelect = "ask",
  },
  command = "lldb-vscode",
  env = {
    LLDB_LAUNCH_FLAG_IN_TTY = "YES",
  },
  name = "lldb",
}

dap.adapters.python = {
  type = "executable",
  command = "python",
  args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch File",

    program = "${file}",
  },
}

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

require("nvim-dap-virtual-text").setup({})

vim.api.nvim_create_user_command("Lldb", function(command)
  local config = {
    type = "lldb",
    name = command.fargs[1],
    request = "launch",
    program = command.fargs[1],
    args = { vim.list_slice(command.fargs, 2, vim.tbl_count(command.fargs)) },
  }

  dap.run(config)
  dap.repl.open()
end, { nargs = "+", complete = "file", desc = "Start debugging" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })

vim.keymap.set({ "n", "v", "i" }, "<F1>", dap.step_over, {})
vim.keymap.set({ "n", "v", "i" }, "<F2>", dap.step_into, {})
vim.keymap.set({ "n", "v", "i" }, "<F3>", dap.step_out, {})
vim.keymap.set({ "n", "v", "i" }, "<F4>", dap.pause, {})
vim.keymap.set({ "n", "v", "i" }, "<F5>", dap.continue, {})
vim.keymap.set({ "n", "v", "i" }, "<F6>", dapui.toggle, {})
vim.keymap.set({ "n", "v", "i" }, "<F7>", dap.toggle_breakpoint, {})
vim.keymap.set({ "n", "v", "i" }, "<F8>", function()
  vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
    dap.set_breakpoint(condition)
  end)
end, {})
vim.keymap.set({ "n", "v", "i" }, "<F9>", function()
  vim.ui.input({ prompt = "Log point message: " }, function(message)
    dap.set_breakpoint(nil, nil, message)
  end)
end, {})
