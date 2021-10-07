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
        r = { "<cmd>lua require('dap').repl.open()<CR>", "REPL" },
        l = { "<cmd>lua require('dap').run_last()<CR>", "Run Last" },
        m = {
          "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
          "Log point",
        },
        i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
        t = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
        o = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
        u = {
          name = "+ui",
          t = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle" },
          f = { "<cmd>lua require('dapui').float_element()<CR>", "Float" },
        },
      },
    },
  }

  wk.register(keymap, { buffer = bufnr, prefix = "<leader>" })
end

return M
