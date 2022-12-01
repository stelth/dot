tasks = require("tasks")
dapui = require("dapui")

local configure_args = require("tasks.config").default_params.cmake.args.configure
table.insert(configure_args, "-D")
table.insert(configure_args, "CMAKE_CXX_FLAGS=-gdwarf-4")

tasks.setup({
  cmake = {
    args = {
      configure = configure_args,
    },
  },
  dap_open_command = dapui.open,
})
