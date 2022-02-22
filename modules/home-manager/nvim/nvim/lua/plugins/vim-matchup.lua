local M = {}

M.setup = function()
  vim.g.matchup_paren_offscreen = {
    method = "status_manual",
  }
end

return M
