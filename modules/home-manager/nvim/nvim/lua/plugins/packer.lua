local M = {}

local util = require("util")
util.nnoremap("<leader>hpp", ":PackerSync<CR>")
util.nnoremap("<leader>hps", ":PackerStatus<CR>")
util.nnoremap("<leader>hpi", ":PackerInstall<CR>")
util.nnoremap("<leader>hpc", ":PackerCompile<CR>")

local setup = function() end

M.use = function(use)
  use({ "wbthomason/packer.nvim", opt = true, config = setup })
end

return M
