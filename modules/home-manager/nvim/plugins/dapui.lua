local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

require("telescope").load_extension("dap")

dapui.setup({
  layouts = {
    {
      elements = {
        "scopes",
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

daptext.setup()

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "Constant" })
vim.fn.sign_define("DapBreakpointRejected", { text = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

vim.keymap.set("n", "<leader><leader>", function()
  dapui.close()
  dap.terminate()
  daptext.refresh()
end, { desc = "DAP Close" })

vim.keymap.set("n", "<Up>", dap.continue, { desc = "DAP Continue" })

vim.keymap.set("n", "<Down>", dap.step_over, { desc = "DAP Step Over" })

vim.keymap.set("n", "<Right>", dap.step_into, { desc = "DAP Step Into" })

vim.keymap.set("n", "<Left>", dap.step_out, { desc = "DAP Step Out" })

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })

vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint Condition: "))
end, { desc = "DAP Conditional Breakpoint" })

vim.keymap.set("n", "<leader>rc", dap.run_to_cursor, { desc = "DAP Run To Cursor" })
