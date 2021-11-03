local M = {}

local util = require("util")
util.nnoremap("<leader>gd", ":DiffviewOpen<CR>")

local setup = function()
  require("diffview").setup({})
end

M.use = function(use)
  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = setup,
  })
end

return M
