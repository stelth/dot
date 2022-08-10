local default_colors = require("kanagawa.colors").setup()

require("kanagawa").setup({
    dimInactive = true,
    globalStatus = true,
})

vim.cmd.colorscheme("kanagawa")
