local M = {}

local setup = function()
  vim.g.matchup_paren_offscreen = {
    method = "status_manual",
  }
end

M.use = function(use)
  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = setup,
  })
end

return M
