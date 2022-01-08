vim.api.nvim_set_keymap("n", "<leader>dbc", "", {
  callback = function()
    require("dap").set_breakpoint(vim.fn.input("Breakpoint Condition: "))
  end,
  desc = "Conditional breakpoint",
})
vim.api.nvim_set_keymap("n", "<leader>dbt", "", {
  callback = require("dap").toggle_breakpoint,
  desc = "Toggle breakpoint",
})
vim.api.nvim_set_keymap("n", "<leader>dbs", "", {
  callback = function()
    require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
  end,
  desc = "Breakpoint with message",
})
vim.api.nvim_set_keymap("n", "<leader>dc", "", {
  callback = require("dap").continue,
  desc = "Continue",
})
vim.api.nvim_set_keymap("n", "<leader>dd", "", {
  callback = function()
    require("dapconfig.debug").lldb(vim.fn.input("Executable: "))
  end,
  desc = "Debug Application",
})
vim.api.nvim_set_keymap("n", "<leader>de", "", {
  callback = require("dapui").eval,
  desc = "Eval",
})
vim.api.nvim_set_keymap("n", "<leader>dp", "", {
  callback = require("dap").pause,
  desc = "Pause",
})
vim.api.nvim_set_keymap("n", "<leader>dq", "", {
  callback = function()
    require("dapui").close()
    require("dap").terminate()
    require("nvim-dap-virtual-text").refresh()
  end,
  desc = "Terminate",
})
vim.api.nvim_set_keymap("n", "<leader>dsi", "", {
  callback = require("dap").step_into,
  desc = "Step into",
})
vim.api.nvim_set_keymap("n", "<leader>dso", "", {
  callback = require("dap").step_out,
  desc = "Step out",
})
vim.api.nvim_set_keymap("n", "<leader>dsv", "", {
  callback = require("dap").step_over,
  desc = "Step over",
})
vim.api.nvim_set_keymap("n", "<leader>du", "", {
  callback = require("dapui").toggle,
  desc = "Toggle DAP UI",
})
