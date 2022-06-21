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
