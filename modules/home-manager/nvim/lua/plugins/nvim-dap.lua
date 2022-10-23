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

require("dap-python").setup("/etc/profiles/per-user/coxj/bin/python")

dapui.setup({
  layouts = {
    {
      elements = {
        "scopes",
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 60,
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

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
