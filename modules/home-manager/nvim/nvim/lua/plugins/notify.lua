local M = {}

local do_keymaps = function()
  local map = {
    n = { "<cmd>lua require('telescope').extensions.notify.notify()<CR>", "Notifications"},
  }
  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("NotifyKeyMaps", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

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
