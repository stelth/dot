local M = {}

local setup = function() end

M.use = function(use)
  use({
    "JoosepAlviste/nvim-ts-context-commentstring",
    module = "ts_context_commentstring",
    config = setup,
  })
end

return M
