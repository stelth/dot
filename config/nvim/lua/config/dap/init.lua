require("dap-python").setup("python3")

local dap = require("dap")
dap.adapters.lldb = {
	type = "executable",
	command = "lldb-vscode",
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

dap.configurations.c = dap.configurations.cpp

dap.listeners.after["event_initialized"]["me"] = function()
	require("util").log("Enabling dap virtual text")
	vim.g.dap_virtual_text = true
end

dap.listeners.after["event_terminated"]["me"] = function()
	require("util").log("Disabling dap virtual text")
	vim.g.dap_virtual_text = false
end

require("config.dap.keys").setup()
