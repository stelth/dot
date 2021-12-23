local M = {}

local do_keymaps = function()
  local map = {
    [":"] = { "<cmd>FineCmdline<CR>", "Cmd Line" },
  }

  require("which-key").register(map)
end

require("util.au").group("FineCmdlineKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("fine-cmdline").setup({
    cmdline = {
      enable_keymaps = false,
    },
  })
end

M.use = function(use)
  use({
    "VonHeikemen/fine-cmdline.nvim",
    requires = { "Muniftanjim/nui.nvim" },
    config = setup,
  })
end

return M
