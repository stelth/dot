local M = {}

local do_keymaps = function()
  local map = {
    g = {
      g = { "<cmd>Neogit kind=split<CR>", "Neogit" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("NeogitKeymaps", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("neogit").setup({
    kind = "split",
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  })
end

M.use = function(use)
  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = setup,
  })
end

return M
