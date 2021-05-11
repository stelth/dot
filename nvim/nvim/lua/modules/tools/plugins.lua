local tools = {}
local conf = require('modules.tools.config')

tools['JoosepAlviste/nvim-ts-context-commentstring'] = {
    event = 'BufReadPre'
}

tools['tpope/vim-commentary'] = {
    event = 'BufReadPre'
}

tools['liuchengxu/vista.vim'] = {
  cmd = 'Vista',
  config = conf.vim_vista
}

tools['numToStr/FTerm.nvim'] = {
    config = conf.fterm
}

return tools
