local M = {}

local dap = require("dap")

M.lldb = function(command, ...)
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

return M
