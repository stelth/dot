vim.o.background = "dark"

vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_invert_selection = 0

vim.cmd([[colorscheme gruvbox]])

vim.highlight.create("ColorColumn", { ctermbg = 0, guibg = vim.lightgrey })
vim.highlight.create("SignColumn", { guibg = "NONE" })
vim.highlight.create("CursorLineNR", { guibg = "NONE" })
vim.highlight.create("Normal", { guibg = "NONE" })
vim.highlight.create("LineNR", { guifg = "#5EACD3" })
vim.highlight.create("netrwDir", { guifg = "#5EACD3" })
vim.highlight.create("qfFileName", { guifg = "#AED75F" })
vim.highlight.create("TelescopeBorder", { guifg = "#5EACD" })
