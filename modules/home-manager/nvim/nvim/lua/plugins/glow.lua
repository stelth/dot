local M = {}

local util = require("util")
util.nnoremap("<leader>og", ":Glow<CR>")

local setup = function() end

M.use = function(use)
  use({
    "npxbr/glow.nvim",
    cmd = "Glow",
    config = setup,
  })
end

return M
