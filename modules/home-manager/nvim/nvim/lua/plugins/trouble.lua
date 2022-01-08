local M = {}

local setup = function()
  require("trouble").setup({
    auto_open = false,
    use_diagnostic_signs = true,
  })

  vim.api.nvim_set_keymap("n", "<leader>xx", ":TroubleToggle<CR>", { desc = "Trouble" })
  vim.api.nvim_set_keymap(
    "n",
    "<leader>xw",
    ":TroubleToggle lsp_workspace_diagnostics<CR>",
    { desc = "Workspace diagnostics" }
  )
  vim.api.nvim_set_keymap(
    "n",
    "<leader>xd",
    ":TroubleToggle lsp_document_diagnostics<CR>",
    { desc = "Document Diagnostics" }
  )
end

M.use = function(use)
  use({
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = setup,
  })
end

return M
