require("config.lsp.diagnostics")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {
      "lua-language-server",
    },
    settings = {
      Lua = {
        diagnostics = {
          globals = {
            "vim",
          },
        },
      },
    },
  },
})

local servers = {
  bashls = {},
  cmake = {},
  clangd = {},
  dockerls = {},
  jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
  ["null-ls"] = {},
  texlab = {},
  pyright = {},
  rnix = {},
  sumneko_lua = luadev,
  vimls = {},
  tsserver = {},
  yamlls = {},
}

require("config.lsp.null-ls").setup()

local lspconfig = require("lspconfig")
for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = require('config.lsp.util').on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config))
end
