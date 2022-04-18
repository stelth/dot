local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

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
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
    },
  },
  cmake = {},
  jsonls = { cmd = { "vscode-json-languageserver", "--stdio" } },
  pyright = {},
  rnix = {},
  sumneko_lua = luadev,
  yamlls = {},
}

local lspconfig = require("lspconfig")
for server, config in pairs(servers) do
  lspconfig[server].setup(require("lsp.util").make_config(config))
end

require("lsp.null-ls").setup()
