local M = {}

local setup = function()
  vim.o.background = "dark"

  vim.g.tokyonight_style = "night"
  vim.g.tokyonight_sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "packer",
    "spectre_panel",
    "NeogitStatus",
    "help",
  }
  vim.g.tokyonight_cterm_colors = false
  vim.g.tokyonight_terminal_colors = true
  vim.g.tokyonight_italic_comments = true
  vim.g.tokyonight_italic_keywords = true
  vim.g.tokyonight_ialic_functions = false
  vim.g.tokyonight_italic_variables = false
  vim.g.tokyonight_transparent = false
  vim.g.tokyonight_hide_inactive_statusline = true
  vim.g.tokyonight_dark_sidebar = true
  vim.g.tokyonight_dark_float = true
  vim.g.tokyonight_color = {}

  require("tokyonight").colorscheme()
end

M.use = function(use)
  use({
    "folke/tokyonight.nvim",
    config = setup,
  })
end

return M
