local dap = require("dap")

local function outputOf(cmd, raw)
  local f = assert(io.popen(cmd, "r"))
  local s = assert(f:read("*a"))
  f:close()
  if raw then
    return s
  end
  s = string.gsub(s, "^%s+", "")
  s = string.gsub(s, "%s+$", "")
  s = string.gsub(s, "[\n\r]+", " ")

  return s
end

dap.adapters.lldb = {
  type = "executable",
  command = outputOf("which lldb-vscode"),
  name = "lldb",
}

dap.configurations.cpp = {
  name = "Launch",
  type = "lldb",
  request = "launch",
  program = function()
    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = {},
  runInTerminal = false,
}
dap.configurations.c = dap.configurations.cpp

require("dap-python").setup(outputOf("which python"))

require("dapui").setup()
require("config.dap.keys").setup()
