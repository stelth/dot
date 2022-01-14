local M = {}

local setup = function()
  require("util.au").group("md", function(grp)
    grp.FileType = {
      "java",
      function()
        require("lsp.jdtls")
      end,
    }
  end)
end

M.use = function(use)
  use({
    "mfussenegger/nvim-jdtls",
    config = setup,
  })
end

return M
