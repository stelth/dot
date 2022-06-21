local dap = require("dap")

dap.adapters.lldb = {
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
