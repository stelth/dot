local M = {}

local setup = function()
  require("bufferline").setup({
    options = {
      show_close_icon = true,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      separator_style = "slant",
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. sym .. n
        end
        return s
      end,
    },
  })

  local wk = require("which-key")
  local map = {
    b = {
      name = "+buffer",
      ["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
      ["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
      ["["] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
      ["n"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
      ["]"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
      ["d"] = { "<cmd>:bd<CR>", "Delete Buffer" },
      ["g"] = { "<cmd>:BufferLinePick<CR>", "Goto Buffer" },
    },
  }

  wk.register(map, { prefix = "<leader>" })
end

function M.use(use)
  use({
    "akinsho/nvim-bufferline.lua",
    event = "BufNew",
    config = setup,
    requires = {
      "kyazdani42/nvim-web-devicons",
      "folke/which-key.nvim",
    },
  })
end

return M
