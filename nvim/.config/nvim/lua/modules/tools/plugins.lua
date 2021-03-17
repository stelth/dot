local tools = {}
local conf = require('modules.tools.config')

tools['glepnir/prodoc.nvim'] = {event = 'BufReadPre'}

tools['brooth/far.vim'] = {
    cmd = {'Far', 'Farp'},
    config = function() vim.g['far#source'] = 'rg' end
}

return tools
