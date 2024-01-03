{...}:
/*
lua
*/
''
  ----------------------------------
  -- General Settings
  -- ----------------------------------
  vim.loader.enable()

  local indent = 2

  vim.opt.clipboard = "unnamedplus"
  vim.opt.conceallevel = 3
  vim.opt.diffopt:append("linematch:60")
  vim.opt.expandtab = true
  vim.opt.grepprg = "rg --vimgrep"
  vim.opt.grepformat = "%f:%l:%c:%m"
  vim.opt.inccommand = "nosplit"
  vim.opt.laststatus = 0
  vim.opt.number = true
  vim.opt.relativenumber = true
  vim.opt.shiftwidth = indent
  vim.opt.signcolumn = 'yes'
  vim.opt.smartindent = true
  vim.opt.spell = true
  vim.opt.swapfile = false
  vim.opt.tabstop = indent
  vim.opt.undofile = true
  vim.opt.undolevels = 10000
  vim.opt.updatetime = 50
  vim.opt.wildmode = "longest:full,full"

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

  vim.cmd.colorscheme("catppuccin")

  vim.api.nvim_create_autocmd({"TextYankPost"}, {
    callback = function()
      vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
  })

  local M = {}
''
