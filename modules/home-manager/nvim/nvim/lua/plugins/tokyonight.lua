local M = {}

local setup = function()
  vim.g.material_style = "pale_night"
  vim.g.material_italic_comments = 1
  vim.g.material_italic_keywords = 1
  vim.g.material_italic_functions = 1
  vim.g.material_lsp_underline = 1

  vim.g.sonokai_style = "atlantis"
  vim.g.sonokai_enable_italic = 1
  vim.g.sonokai_disable_italic_comment = 1
  vim.g.sonokai_diagnostic_virtual_text = "colored"

  vim.g.edge_style = "neon"
  vim.g.edge_enable_italic = 1
  vim.g.edge_disable_italic_comment = 0
  vim.g.edge_transparent_background = 0

  vim.g.embark_terminal_italics = 1

  vim.g.nightflyTransparent = 0

  vim.g.nvcode_termcolors = 256

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

function M.use(use)
  use({
    "folke/tokyonight.nvim",
    event = "VimEnter",
    config = setup,
  })
end

return M