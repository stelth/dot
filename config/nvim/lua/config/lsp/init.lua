if vim.lsp.setup then
	vim.lsp.setup({
		floating_preview = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
		diagnostics = {
			signs = { error = " ", warning = " ", hint = " ", information = " " },
			display = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
		},
		completion = {
			kind = {
				Class = " ",
				Color = " ",
				Constant = " ",
				Constructor = " ",
				Enum = "了 ",
				EnumMember = " ",
				Field = " ",
				File = " ",
				Folder = " ",
				Function = " ",
				Interface = "ﰮ ",
				Keyword = " ",
				Method = "ƒ ",
				Module = " ",
				Property = " ",
				Snippet = "﬌ ",
				Struct = " ",
				Text = " ",
				Unit = " ",
				Value = " ",
				Variable = " ",
			},
		},
	})
else
	require("config.lsp.diagnostics")
	require("config.lsp.kind").setup()
end

local function on_attach(client, bufnr)
	require("config.lsp.formatting").setup(client, bufnr)
	require("config.lsp.keys").setup(client, bufnr)
	require("config.lsp.completion").setup(client, bufnr)
	require("config.lsp.highlighting").setup(client)
	require("config.lsp.signature").setup()
end

local function make_config()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}

	return { capabilities = capabilities, on_attach = on_attach }
end

local function setup_servers()
	local lspinstall = require("lspinstall")
	lspinstall.setup()

	local servers = lspinstall.installed_servers()

	for _, server in pairs(servers) do
		local config = make_config()

		if server == "lua" then
			local luadev = require("lua-dev").setup({})
			config = vim.tbl_deep_extend("force", config, luadev)
		end

		if server == "vim" then
			config.init_options = {
				isNeovim = true,
			}
		end

		if server == "efm" then
			config = vim.tbl_deep_extend("force", config, require("config.lsp.efm").config)
		end

		require("lspconfig")[server].setup(config)
	end

	require("null-ls").setup(make_config())
end

setup_servers()
