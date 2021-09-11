local status, impatient = pcall(require, "impatient")
if status then
  impatient.enable_profile()
end
require("util")
require("options")

vim.defer_fn(function()
  require("plugins")
end, 0)
