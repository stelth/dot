local execute = vim.api.nvim_command
local fn = vim.fn
local global = require('global')

local install_path = global.data_dir .. "pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "https://github.com/wbthomason/packer.nvim", install_path})
    execute("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])
