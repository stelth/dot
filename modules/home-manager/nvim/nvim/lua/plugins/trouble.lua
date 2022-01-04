local M = {}

local setup = function()
  require("trouble").setup({
    auto_open = false,
    use_diagnostic_signs = true,
  })

  local map = {
    x = {
      x = { "<cmd>TroubleToggle<CR>", "Trouble" },
      w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>", "Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle lsp_document_diagnostics<CR>", "Document Diagnostics" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "folke/trouble.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = setup,
  })
end

return M
