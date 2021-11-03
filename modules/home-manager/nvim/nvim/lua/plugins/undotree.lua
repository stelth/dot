local M = {}

local util = require("util")
util.nnoremap("<leader>u", ":UndotreeToggle<CR>")

function M.use(use)
  use({
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  })
end

return M
