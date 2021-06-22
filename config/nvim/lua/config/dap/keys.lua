local wk = require("which-key")

local M = {}

M.setup = function()
	local keymap = {
		c = {
			name = "+Code",
			d = {
				name = "+Debugger",
				c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
				s = {
					name = "+Step",
					v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
					i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
					o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
				},
				b = {
					name = "+Breakpoints",
					t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle" },
					r = {
						"<cmd>lua require('dap').set_breakpoint(vim.fn.input(\"Breakpoint Condition: \"))<CR>",
						"Conditional Breakpoint",
					},
					m = {
						"<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input(\"Log point message: \"))<CR>",
						"Message Breakpoint",
					},
				},
				r = {
					name = "+REPL",
					o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
					l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
				},
				i = {
					name = "+Info",
					c = { "<cmd>Telescope dap commands<CR>", "Commands" },
					o = { "<cmd>Telescope dap configurations<CR>", "Configurations" },
					b = { "<cmd>Telescope dap list_breakpoints<CR>", "Breakpoints" },
					v = { "<cmd>Telescope dap variables<CR>", "Variables" },
					f = { "<cmd>Telescope dap frames<CR>", "Frames" },
				},
			},
		},
	}
	wk.register(keymap, { prefix = "<leader>", noremap = true, silent = true })
end

return M
