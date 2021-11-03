local M = {}

local util = require("util")
util.nnoremap("<leader>u", ":UndotreeToggle<CR>")

local setup = function() end

M.use = function(use)
  use({
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = setup,
  })
end

return M
