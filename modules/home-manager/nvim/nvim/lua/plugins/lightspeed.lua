local M = {}

M.setup = function()
  require("lightspeed").setup({
    repeat_ft_with_target_char = true,
  })
end

return M
