require("dap-python").setup(require("util").get_python_path(), { include_configs = false })

local dap = require('dap')

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    justMyCode = false,
    program = "${file}",
    console = "internalConsole",
    pythonPath = require("util").get_python_path(),
  },
  {
    type = "python",
    request = "attach",
    name = "Attach remote",
    justMyCode = false,
    pythonPath = require("util").get_python_path(),
    host = function()
      local value = vim.fn.input("Host [127.0.0.1]: ")
      if value ~= "" then
        return value
      end
      return "127.0.0.1"
    end,
    port = function()
      return tonumber(vim.fn.input("Port [5678]: ")) or 5678
    end,
  },
}