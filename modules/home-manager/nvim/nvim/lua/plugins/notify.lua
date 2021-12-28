local M = {}

local setup = function()
  vim.notify = function(msg, log_level, opts)
    if msg:match("offset_encodings") then
      return
    end
    require("notify").notify(msg, log_level, opts)
  end
end

M.use = function(use)
  use({
    "rcarriga/nvim-notify",
    config = setup,
  })
end

return M
