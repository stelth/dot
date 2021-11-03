local M = {}

local util = require("util")
util.nnoremap("<leader>hpp", ":PackerSync<CR>")
util.nnoremap("<leader>hps", ":PackerStatus<CR>")
util.nnoremap("<leader>hpi", ":PackerInstall<CR>")
util.nnoremap("<leader>hpc", ":PackerCompile<CR>")

function M.use(use)
  use({ "wbthomason/packer.nvim", opt = true })
end

return M
