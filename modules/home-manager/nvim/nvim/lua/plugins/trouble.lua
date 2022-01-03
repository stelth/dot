local M = {}

local do_keymaps = function()
  local map = {
    x = {
      x = { "<cmd>TroubleToggle<CR>", "Trouble" },
      w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<CR>", "Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle lsp_document_diagnostics<CR>", "Document Diagnostics" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("util.au").group("TroubleKeyMaps", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("trouble").setup({
    auto_open = false,
    use_diagnostic_signs = true,
  })
end

M.use = function(use)
  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = setup,
  })
end

return M
