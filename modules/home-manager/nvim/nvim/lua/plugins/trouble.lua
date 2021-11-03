local M = {}

local util = require("util")
util.nnoremap("<leader>xx", ":TroubleToggle<CR>")
util.nnoremap("<leader>xw", ":TroubleToggle lsp_workspace_diagnostics<CR>")
util.nnoremap("<leader>xd", ":TroubleToggle lsp_document_diagnostics<CR>")

local setup = function()
  require("trouble").setup({ auto_open = false })
end

function M.use(use)
  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    requires = { "nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    config = setup,
  })
end

return M
