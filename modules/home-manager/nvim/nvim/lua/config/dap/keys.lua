local wk = require("which-key")

local M = {}

M.setup = function(_, bufnr)
  local keymap = {
    c = {
      name = "+code",
      d = {
        name = "+debugger",
        b = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
        B = {
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
          "Set Conditional Breakpoint",
        },
        c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
        dr = { "<cmd>lua require('dap').repl.open()<CR>", "REPL" },
        dl = { "<cmd>lua require('dap').run_last()<CR>", "Run Last" },
        lp = {
          "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
          "Log point",
        },
        si = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
        st = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
        so = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
        ui = { "<cmd>lua require('dapui').toggle()<CR>", "UI" },
      },
    },
  }

  wk.register(keymap, { buffer = bufnr, prefix = "<leader>" })
end

return M
