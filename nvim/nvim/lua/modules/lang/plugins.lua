local lang = {}
local conf = require('modules.lang.config')

lang['nvim-treesitter/nvim-treesitter'] = {
  event = 'BufRead',
  after = 'telescope.nvim',
  config = conf.nvim_treesitter
}

lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
  after = 'nvim-treesitter'
}

lang['nvim-treesitter/playground'] = {
    after = 'nvim-treesitter'
}

lang['mattn/vim-maketable'] = {
  cmd = {'MakeTable', 'UnmakeTable', 'MakeTable'}
}

lang['folke/lua-dev.nvim'] = {
}

return lang
