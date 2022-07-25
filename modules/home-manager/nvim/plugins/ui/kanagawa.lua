local default_colors = require("kanagawa.colors").setup()

require("kanagawa").setup({
  dimInactive = true,
  globalStatus = true,
  overrides = {
    LeapLabelPrimary = {
      bg = default_colors.sumiInk1,
      fg = default_colors.springGreen,
    },
    LeapLabelSecondary = {
      bg = default_colors.sumiInk1,
      fg = default_colors.springBlue,
    },
    LeapMatch = {
      bg = default_colors.sumiInk1,
      fg = default_colors.waveRed,
      italic = true,
    },
    LeapBackdrop = {
      bg = default_colors.sumiInk1,
      fg = default_colors.sumiInk4,
    },
  },
})

vim.cmd.colorscheme("kanagawa")
