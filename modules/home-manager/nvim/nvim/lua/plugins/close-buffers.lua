local M = {}

local do_keymaps = function()
  local map = {
    b = {
      d = { "<cmd>:BDelete this<CR>", "Delete Buffer" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("MapCloseBufferKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function() end

M.use = function(use)
  use({
    "kazhala/close-buffers.nvim",
    cmd = "BDelete",
    config = setup,
  })
end

return M
