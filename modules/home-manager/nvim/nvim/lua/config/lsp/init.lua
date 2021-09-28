require("config.lsp.diagnostics")

local function on_attach(client, bufnr)
  require("config.lsp.formatting").setup(client, bufnr)
  require("config.lsp.keys").setup(client, bufnr)
  require("config.lsp.highlighting").setup(client)
end

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
  jdtls = { cmd = { "jdt-language-server" } },
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
