local M = {}

local setup = function()
  local util = require("util")
  util.nnoremap("n", "<cmd>execute('normal!' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>")
  util.nnoremap("N", "<cmd>execute('normal!' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>")
  util.nnoremap("*", "*<cmd>lua require('hlslens').start()<CR>")
  util.nnoremap("#", "#<cmd>lua require('hlslens').start()<CR>")
  util.nnoremap("g*", "g*<cmd>lua require('hlslens).start()<CR>")
  util.nnoremap("g#", "g#<cmd>lua require('hlslens').start()<CR>")
  util.nnoremap("<BS>", ":noh<CR>")
end

M.use = function(use)
  use({
    "kevinhwang91/nvim-hlslens",
    config = setup,
  })
end

return M
