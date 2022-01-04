local M = {}

local setup = function()
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

M.use = function(use)
  use({
    "wbthomason/packer.nvim",
    config = setup,
  })
end

return M
