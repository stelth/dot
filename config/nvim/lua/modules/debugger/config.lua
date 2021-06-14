local config = {}

function config.nvim_dap()
    require('dap-python').setup('python3')

    require('modules.debugger.dapkeymaps').setup_keymaps()
end

return config
