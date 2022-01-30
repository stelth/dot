require("lsp.diagnostics").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
  },
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
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = require("lsp.util").on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config))
end

require("lsp.null-ls").setup()
