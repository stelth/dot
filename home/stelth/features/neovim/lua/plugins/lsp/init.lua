local make_config = require("plugins.lsp.config").make_config

local lspconfig = require("lspconfig")

lspconfig.bashls.setup(make_config({}))

lspconfig.clangd.setup(make_config({}))

lspconfig.jsonls.setup(make_config({}))

require("neodev").setup({
	override = function(root_dir, library)
		if root_dir:find("repos/dot", 1, true) == 1 then
			library.enabled = true
			library.plugins = true
			library.types = true
			library.runtime = true
		end
	end,
})
lspconfig.lua_ls.setup(make_config({
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}))

lspconfig.marksman.setup(make_config({}))

lspconfig.neocmake.setup(make_config({}))

lspconfig.nil_ls.setup(make_config({}))

lspconfig.pylsp.setup(make_config({}))

lspconfig.taplo.setup(make_config({}))

lspconfig.yamlls.setup(make_config({}))
