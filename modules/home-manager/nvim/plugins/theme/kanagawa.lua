local default_colors = require("kanagawa.colors").setup()

require("kanagawa").setup({
  dimInactive = true,
  globalStatus = true,
  overrides = {
    LeapLabelPrimary = { fg = default_colors.autumnRed },
    LeapLabelSecondary = { fg = default_colors.autumnRed },
    LeapMatch = { fg = default_colors.waveRed, italic = true },
  },
})

vim.cmd("colorscheme kanagawa")
