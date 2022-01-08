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

  vim.api.nvim_set_keymap("n", "<leader>`", ":e #<CR>", { desc = "Switch to other buffeer" })
  vim.api.nvim_set_keymap("n", "<leader>bb", ":e #<CR>", { desc = "Switch to other buffer" })
  vim.api.nvim_set_keymap("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
  vim.api.nvim_set_keymap("n", "<leader>b[", ":BufferLineCyclePrev<CR>", { desc = "Previoius buffer" })
  vim.api.nvim_set_keymap("n", "<leader>bn", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
  vim.api.nvim_set_keymap("n", "<leader>b]", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
  vim.api.nvim_set_keymap('n', '<leader>bg', ':BufferLinePick<CR>', {desc = "Pick Buffer"})
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
