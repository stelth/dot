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

tools['akinsho/nvim-toggleterm.lua'] = {
    config = conf.toggleterm
}

return tools
