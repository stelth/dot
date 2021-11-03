local M = {}

function M.use(use)
  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
  })
end

return M
