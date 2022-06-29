-- ----------------------------------
-- General Settings
-- ----------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.backup = false
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "80"
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.guicursor = ""
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.softtabstop = 4
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.updatetime = 50
vim.opt.wrap = false

-- don't load the plugins below
vim.g.did_load_filetypes = 0
vim.g.loaded_2html_plugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.do_filetype_lua = 1

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = "120",
    })
  end,
})
