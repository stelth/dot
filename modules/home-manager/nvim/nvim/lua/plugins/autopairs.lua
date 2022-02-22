local M = {}

M.setup = function()
  require("nvim-autopairs").setup({
    enable_check_bracket_line = false,
  })
end

return M
