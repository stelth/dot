require("formatter").setup({
	filetype = {
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
		c = {
			require("formatter.filetypes.c").clangformat,
		},
		cmake = {
			require("formatter.filetypes.cmake").cmakeformat,
		},
		cpp = {
			require("formatter.filetypes.cpp").clangformat,
		},
		json = {
			require("formatter.filetypes.json").prettierd,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettierd,
		},
		nix = {
			require("formatter.filetypes.nix").alejandra,
		},
		python = {
			require("formatter.filetypes.python").black,
			require("formatter.filetypes.python").isort,
		},
		sh = {
			require("formatter.filetypes.sh").shfmt,
		},
		toml = {
			require("formatter.filetypes.toml").taplo,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettierd,
		},
	},
})

local M = {}

local warn = function(msg, name)
	vim.notify(msg, vim.log.levels.WARN, { title = name })
end

local info = function(msg, name)
	vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local autoformat = true
M.toggle_formatting = function()
	autoformat = not autoformat
	if autoformat then
		info("enabled format on save", "Formatting")
	else
		warn("disabled format on save", "Formatting")
	end
end

local augroup = vim.api.nvim_create_augroup("__formatter__", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = augroup,
	callback = function()
		if autoformat then
			vim.cmd("FormatWrite")
		end
	end,
})

return M
