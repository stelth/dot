local M = {}

local setup = function()
  local map = {
    b = {
      d = { "<cmd>:BDelete this<CR>", "Delete Buffer" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "kazhala/close-buffers.nvim",
    config = setup,
  })
end

return M
