local M = {}

local util = require("util")
util.nnoremap("<leader>qs", ":lua require('persistence').load()<CR>")
util.nnoremap("<leader>ql", ":lua require('persistence').load({last = true})<CR>")
util.nnoremap("<leader>qd", ":lua require('persistence').stop()<CR>")

local setup = function()
  require("persistence").setup()
end

M.use = function(use)
  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = setup,
  })
end

return M
