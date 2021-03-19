local tools = {}
local conf = require('modules.tools.config')

tools['glepnir/prodoc.nvim'] = {
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

return tools
