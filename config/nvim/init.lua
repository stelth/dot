require("util")
require("options")

local global = require('util.global')

vim.defer_fn(function()
  require("plugins")
end, 0)

package.path = package.path .. ";".. global.data_dir .. "?.lua"
if vim.fn.filereadable(global.data_dir .. 'packer_compiled.lua') then
  require('packer_compiled')
end
