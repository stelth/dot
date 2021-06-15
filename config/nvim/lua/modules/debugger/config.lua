local config = {}

function config.nvim_dap()
    require('dap-python').setup('python3')

    local dap = require('dap')
    dap.adapters.lldb = {
        type = 'executable',
        command = 'lldb-vscode',
        name = 'lldb'
    }

    dap.configurations.cpp = {
        {
            name = 'Launch',
            type = 'lldb',
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {}
        }
    }

    dap.configurations.c = dap.configurations.cpp

    require('modules.debugger.dapkeymaps').setup_keymaps()
end

return config
