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

local servers = {
	bashls = {},
	cmake = {},
	clangd = {},
	efm = require("config.lsp.efm").config,
	jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
	texlab = {},
	pyright = {},
	sumneko_lua = require("lua-dev").setup({
		lspconfig = { cmd = { "lua-language-server" } },
	}),
	vimls = {},
	yamlls = {},
}

local function setup_servers()
	local lspconfig = require("lspconfig")
	for server, config in pairs(servers) do
		lspconfig[server].setup(vim.tbl_deep_extend("force", make_config(), config))
		local cfg = lspconfig[server]
		if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
			vim.notify(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
		end
	end

	require("null-ls").setup(make_config())
end

setup_servers()
