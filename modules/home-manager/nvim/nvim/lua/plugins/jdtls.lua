local M = {}

M.setup = function()
  require("util.au").group("java", function(grp)
    grp.FileType = {
      "java",
      function()
        require("lsp.jdtls")
      end,
    }
  end)
end

return M
