local status, impatient = pcall(require, "impatient")
if status then
  impatient.enable_profile()
end

pcall(require, "packer_compiled")
require("util")
require("options")

vim.defer_fn(function()
  require("plugins")
end, 0)
