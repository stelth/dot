local M = {}

local do_keymaps = function()
  local map = {
    u = { "<cmd>UndotreeToggle<CR>", "Undotree" },
  }

  require("which-key").register(map, { prefix = "<leaer>" })
end

require("util.au").group("UndoTreeKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function() end

M.use = function(use)
  use({
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = setup,
  })
end

return M
