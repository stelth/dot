local M = {}

local setup = function()
  require("toggleterm").setup({
    size = 20,
    hide_numbers = true,
    open_mapping = [[<M-`>]],
    shade_filetypes = {},
    shade_terminals = false,
    shading_factor = 0.3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    persist_size = true,
    direction = "horizontal",
  })

  -- Esc twice to get to normal mode
  vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])
end

function M.use(use)
  use({
    "akinsho/nvim-toggleterm.lua",
    keys = "<M-`>",
    config = setup,
  })
end

return M
