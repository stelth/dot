local M = {}

local setup = function() end

M.use = function(use)
  use({ "nathom/filetype.nvim", config = setup })
end

return M
