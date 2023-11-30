local make_config = require("plugins.lsp.config").make_config

local lspconfig = require("lspconfig")

lspconfig.bashls.setup(make_config({}))

lspconfig.clangd.setup(make_config({}))

lspconfig.jsonls.setup(make_config({}))

lspconfig.lua_ls.setup(make_config{
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
})

lspconfig.marksman.setup(make_config({}))

lspconfig.neocmake.setup(make_config({}))

lspconfig.nil_ls.setup(make_config({}))

lspconfig.pylsp.setup(make_config({}))

lspconfig.taplo.setup(make_config({}))

lspconfig.yamlls.setup(make_config({}))
