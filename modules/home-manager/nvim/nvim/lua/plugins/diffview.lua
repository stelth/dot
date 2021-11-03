local M = {}

local setup = function()
  require("diffview").setup({})
end

function M.use(use)
  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = setup,
  })
end

return M
