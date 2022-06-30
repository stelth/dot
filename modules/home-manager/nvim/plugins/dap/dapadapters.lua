local dap = require("dap")

dap.adapters.lldb = {
  type = "executable",
  attach = {
    pidProperty = "pid",
    pidSelect = "ask",
  },
  command = "/etc/profiles/per-user/coxj/bin/lldb-vscode",
  env = {
    LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
  },
  name = "lldb",
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.loop.cwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true,
    args = {},
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

vim.api.nvim_create_user_command("Lldb", function(command)
  local cmd = command.fargs[1]
  local args = vim.list_slice(command.fargs, 2, vim.tbl_count(command.fargs))

  local config = {
    type = "lldb",
    name = cmd,
    request = "launch",
    program = cmd,
    args = args,
  }

  dap.run(config)
  dap.repl.open()
end, { nargs = "+", complete = "file", desc = "Start debugging" })

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
