local M = {}

local util = require("util")
util.nnoremap("<leader>Z", ":lua require('zen-mode').reset()<CR>")
util.nnoremap("<leader>z", ":ZenMode<CR>")

local setup = function()
  require("zen-mode").setup({
    plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
  })
end

M.use = function(use)
  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opt = true,
    wants = "twilight.nvim",
    requires = { "folke/twilight.nvim" },
    config = setup,
  })
end

return M
