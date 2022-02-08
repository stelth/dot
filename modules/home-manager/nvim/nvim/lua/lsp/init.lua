require("lsp.diagnostics").setup()

local luadev = require("lua-dev").setup({
  LspConfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = "vim",
        },
      },
    },
  },
})

local servers = {
  bashls = {},
  cmake = {},
  dockerls = {},
  hls = {},
  jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
  pyright = {},
  rnix = {},
  sumneko_lua = luadev,
  vimls = {},
  tsserver = {},
  yamlls = {},
}

local lspconfig = require("lspconfig")
for server, config in pairs(servers) do
  lspconfig[server].setup(require("lsp.util").make_config(config))
end

require("lsp.null-ls").setup()
require("lsp.clangd_extensions").setup()
