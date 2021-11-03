local M = {}

local util = require("util")
util.nnoremap("<leader>og", ":Glow<CR>")

function M.use(use)
  use({
    "npxbr/glow.nvim",
    cmd = "Glow",
  })
end

return M
