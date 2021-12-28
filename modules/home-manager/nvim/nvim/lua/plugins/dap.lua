local M = {}

local do_keymaps = function()
  local map = {
    d = {
      name = "+debug",
      b = {
        name = "+breakpoint",
        c = {
          "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: '))<CR>",
          "Conditional Breakpoint",
        },
        t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint" },
        s = {
          "<cmd>lua require('dap').set_breakpoint(nil, nil. vim.fn.input('Log point message: '))<CR>",
          "Breakpoint with message",
        },
      },
      c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
      e = { "<cmd>lua require('dapui').eval()<CR>", "Eval" },
      p = { "<cmd>lua require('dap').pause()<CR>", "Pause" },
      q = {
        "<cmd>lua require('dapui').close(); require('dap').terminate();<CR><cmd>DapVirtualTextForceRefresh<CR>",
        "Terminate",
      },
      s = {
        name = "+step",
        i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
        o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
        v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
      },
      u = { "<cmd>lua require('dapui').toggle()<CR>", "Toggle UI" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("DapKeyMaps", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("dapconfig")
end

M.use = function(use)
  use({
    "mfussenegger/nvim-dap",
    module = "dap",
    config = setup,
    requires = {
      "theHamsta/nvim-dap-virtual-text",
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
    },
  })
end

return M
