local debugger = {}
local conf = require('modules.debugger.config')

debugger['mfussenegger/nvim-dap'] = {
    config = conf.nvim_dap,
    requires = {'mfussenegger/nvim-dap-python', opt = true}
}

return debugger
