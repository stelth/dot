local M = {}

local do_keymaps = function()
  local map = {
    h = {
      p = {
        p = { "<cmd>PackerSync<CR>", "Sync" },
        s = { "<cmd>PackerStatus<CR>", "Status" },
        i = { "<cmd>PackerInstall<CR>", "Install" },
        c = { "<cmd>PackerCompile<CR>", "Compile" },
      },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("au").group("PackerKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function() end

M.use = function(use)
  use({ "wbthomason/packer.nvim", opt = true, config = setup })
end

return M
