local api = vim.api
local lspconfig = require 'lspconfig'
local format = require('modules.completion.format')
local global = require('core.global')

if not packer_plugins['lspsaga.nvim'].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

local saga = require 'lspsaga'
saga.init_lsp_saga({
    code_action_icon = '💡'
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
    vim.cmd [[edit]]
end

function _G.open_lsp_log()
    local path = vim.lsp.get_log_path()
    vim.cmd("edit " .. path)
end

vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')

vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Enable underline, use default values
        underline = true,
        -- Enable virtual text, override spacing to 4
        virtual_text = true,
        signs = {enable = true, priority = 20},
        -- Disable a feature
        update_in_insert = false
    })

local enhance_attach = function(client, bufnr)
    local completion = require('completion')
    completion.on_attach()
    if client.resolved_capabilities.document_formatting then
        format.lsp_before_save()
    end
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

lspconfig.gopls.setup {
    cmd = {"gopls", "--remote=auto"},
    on_attach = enhance_attach,
    capabilities = capabilities,
    init_options = {usePlaceholders = true, completeUnimported = true}
}

local sumneko_root_path = vim.fn.expand '~/repos/github.com/sumneko/lua-language-server'
local sumneko_binary = sumneko_root_path .. '/bin'
if global.is_mac then
  sumneko_binary = sumneko_binary .. '/macOS'
else
  sumneko_binary = sumneko_binary .. '/Linux'
end

local sumneko_binary = sumneko_binary .. '/lua-language-server'

lspconfig.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = enhance_attach,
    settings = {
        Lua = {
            diagnostics = {enable = true, globals = {"vim", "packer_plugins"}},
            runtime = {version = "LuaJIT"},
            workspace = {
                library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true}, {})
            }
        }
    }
}

lspconfig.clangd.setup {
    cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu"
    },
    on_attach = enhance_attach
}

local texlab_root_path = vim.fn.expand '~/repos/github.com/latex-lsp/texlab'
local texlab_binary = texlab_root_path .. '/target/release/texlab'

lspconfig.texlab.setup {
    cmd = {
      texlab_binary
    },
    on_attach = enhance_attach
}

local servers = {'pyright', 'bashls', 'vimls', 'cmake', 'jdtls'}

for _, server in ipairs(servers) do
    lspconfig[server].setup {on_attach = enhance_attach}
end
