local M = {}

local setup = function()
  local signs = require("lsp.diagnostics").signs

  signs = {
    error = signs.Error,
    warning = signs.Warn,
    info = signs.Info,
    hint = signs.Hint,
  }

  local severities = {
    "error",
    "warning",
  }

  require("bufferline").setup({
    options = {
      show_close_icon = true,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      separator_style = "thick",
      diagnostics_indicator = function(_, _, diag)
        local s = {}
        for _, severity in ipairs(severities) do
          if diag[severity] then
            table.insert(s, signs[severity] .. diag[severity])
          end
        end
        return table.concat(s, " ")
      end,
    },
  })

  local map = {
    ["`"] = { "<cmd>e #<CR>", "Other Buffer" },
    b = {
      b = { "<cmd>e #<CR>", "Other Buffer" },
      p = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
      ["["] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
      n = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
      ["]"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
      d = { "<cmd>:BDelete this<CR>", "Delete Buffer" },
      g = { "<cmd>BufferLinePick<CR>", "Pick Buffer" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "akinsho/nvim-bufferline.lua",
    config = setup,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  })
end

return M
