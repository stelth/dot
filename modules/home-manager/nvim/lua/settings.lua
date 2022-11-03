-- ----------------------------------
-- General Settings
-- ----------------------------------
require("impatient").enable_profile()

local indent = 2
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.autowrite = true
vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menuone,noselect"
vim.opt.conceallevel = 3
vim.opt.cmdheight = 0
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.errorbells = false
vim.opt.expandtab = true
vim.opt.formatoptions = "jcroqlnt"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.listchars = {
  space = "⋅",
  eol = "↴",
  tab = "__",
  trail = "•",
  extends = "❯",
  precedes = "❮",
  nbsp = "ﰸ",
}
vim.opt.fillchars = {
  fold = " ",
  foldsep = " ",
  foldopen = "",
  foldclose = "",
  diff = "╱",
}
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = indent
vim.opt.shortmess:append("c")
vim.opt.showmode = true
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.spell = true
vim.opt.splitkeep = "screen"
vim.opt.swapfile = false
vim.opt.tabstop = indent
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 50
vim.opt.wildmode = "longest:full,full"
vim.opt.wrap = false

-- don't load the plugins below
vim.g.loaded_2html_plugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_perl_provider = 0
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

require("autocmds")
require("plugins")
require("keymaps")
require("plugins.lsp")
