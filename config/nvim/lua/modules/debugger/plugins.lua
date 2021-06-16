local debugger = {}
local conf = require('modules.debugger.config')

debugger['mfussenegger/nvim-dap'] = {
    config = conf.nvim_dap,
    requires = {'mfussenegger/nvim-dap-python', 'theHamsta/nvim-dap-virtual-text', opt = true}
}

return debugger
