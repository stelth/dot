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

tools['s1n7ax/nvim-terminal'] = {
    event = 'BufReadPre'
}

tools['TimUntersberger/neogit'] = {
    event = 'BufReadPre',
    config = conf.neogit,
    requires = {'nvim-lua/plenary.nvim', opt = true}
}

return tools
