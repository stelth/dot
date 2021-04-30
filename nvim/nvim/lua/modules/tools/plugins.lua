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

tools['brooth/far.vim'] = {
    cmd = {'Far', 'Farp', 'Farf'},
    config = conf.far
}

tools['numToStr/FTerm.nvim'] = {
    config = conf.fterm
}

return tools
