local M = {}

local setup = function() end

M.use = function(use)
  use({
    "ndmitchell/ghcid",
    config = setup,
    rtp = "plugins/nvim",
  })
end

return M
