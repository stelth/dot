local M = {}

local setup = function() end

M.use = function(use)
  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = setup,
  })
end

return M
