local M = {}

local setup = function()
  require("bufferline").setup({
    options = {
      show_close_icon = true,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      separator_style = "slant",
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. sym .. n
        end
        return s
      end,
    },
  })
end

function M.use(use)
  use({
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    config = setup,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  })
end

return M
