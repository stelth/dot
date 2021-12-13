local M = {}

local do_keymaps = function()
  local map = {
    g = {
      d = { "<cmd>DiffviewOpen<CR>", "Diff View" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("DiffViewKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("diffview").setup({})
end

M.use = function(use)
  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    module = "diffview",
    config = setup,
  })
end

return M
