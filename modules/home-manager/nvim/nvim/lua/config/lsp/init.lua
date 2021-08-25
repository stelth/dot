require("config.lsp.diagnostics")

local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)
  require("config.lsp.completion").setup(client, bufnr)
  require("config.lsp.highlighting").setup(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

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

local util = require("util")
local lspconfig = require("lspconfig")
for server, config in pairs(servers) do
  lspconfig[server].setup(vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    },
  }, config))
  local cfg = lspconfig[server]
  if not (cfg and cfg.cmd and vim.fn.executable(cfg.cmd[1]) == 1) then
    util.error(server .. ": cmd not found: " .. vim.inspect(cfg.cmd))
  end
end
