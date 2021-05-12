local api = vim.api
local format = require('modules.completion.format')

if not packer_plugins['lspsaga.nvim'].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

local saga = require 'lspsaga'
saga.init_lsp_saga({
    code_action_icon = '💡'
})

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

local lua_settings = {
    Lua  = {
        runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';' )
        },
        diagnostics = {
            globals = { 'vim' }
        },
        workspace = {
            library = {
                [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
            }
        }
    }
}

local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        capabilities = capabilities,
        on_attach = enhance_attach
    }
end

local function install_servers()
    local required_servers = { "bash", "cmake", "cpp", "latex", "lua", "python", "vim", "yaml" }
    local installed_servers = require('lspinstall').installed_servers()

    for _, server in pairs( required_servers ) do
        if not vim.tbl_contains( installed_servers, server ) then
            require('lspinstall').install_server( server )
        end
    end
end

local function setup_servers()
    local lspinstall = require('lspinstall')
    lspinstall.setup()

    install_servers()

    local servers = lspinstall.installed_servers()

    for _, server in pairs( servers ) do
        local config = make_config()

        if server == "lua" then
            config.settings = lua_settings
        end

        require('lspconfig')[server].setup(config)
    end
end

setup_servers()

require('lspinstall').post_install_hook = function()
    setup_servers()

    vim.cmd('bufdo e')
end
