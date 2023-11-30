local M = {}

M.on_attach = function(client, bufnr)
	require("plugins.lsp.keymaps").keymap_callback(client, bufnr)
	if client.server_capabilities["documentSymbolProvider"] then
		require("nvim-navic").attach(client, bufnr)
	end
end

M.make_config = function(custom_config)
	local default_config = {
		on_attach = M.on_attach,
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		flags = {
			debounce_text_changes = 150,
		},
	}

	return vim.tbl_deep_extend("force", default_config, custom_config)
end

return M
