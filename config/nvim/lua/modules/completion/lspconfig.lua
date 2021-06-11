local api = vim.api

local lspconfig = {}

if not packer_plugins['lspsaga.nvim'].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

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
    if client.name == "cpp" or client.name == "json" then
        client.resolved_capabilities.document_formatting = false
    end
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local saga = require('lspsaga')
    saga.init_lsp_saga({code_action_icon = '💡'})

    require('compe').setup({
        enabled = true,
        autocomplete = true,
        min_length = 1,
        preselect = 'enable',
        documentation = 'true',
        source = {
            path = true,
            buffer = true,
            calc = true,
            nvim_lsp = true,
            nvim_lua = true,
            treesitter = true,
            vsnip = true
        }
    }, bufnr)

    require('lsp_signature').on_attach({
        bind = true,
        use_lspsaga = true,
        hi_parameter = "Search"
    })

    require('modules.completion.lspkeymaps').setup_keymaps(client, bufnr)
end

local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {capabilities = capabilities, on_attach = enhance_attach}
end

lspconfig.install_servers = function()
    local required_servers = {
        "bash", "cmake", "cpp", "efm", "json", "latex", "lua", "python", "vim",
        "yaml"
    }
    local installed_servers = require('lspinstall').installed_servers()

    for _, server in pairs(required_servers) do
        if not vim.tbl_contains(installed_servers, server) then
            require('lspinstall').install_server(server)
        end
    end
end

local function tableMerge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == "table" then
            if type(t1[k] or false) == "table" then
                tableMerge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end

    return t1
end

local efm_config = {
    init_options = {documentFormatting = true},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {{formatCommand = "lua-format -i", formatStdin = true}},
            sh = {
                {
                    lintCommand = "shellcheck -f gcc -x",
                    lintSource = "shellcheck",
                    lintFormats = {
                        "%f:%l:%c: %trror: %m", "%f:%l:%c: %tarning: %m",
                        "%f:%l:%c: %tote: %m"
                    }
                }, {formatCommand = "shfmt -ci -s -bn", formatStdin = true}
            },
            markdown = {
                {
                    lintCommand = "markdownlint -s",
                    lintStdin = true,
                    lintFormats = {"%f:%l %m", "%f:%l:%c %m", "%f: %l: %m"}
                }
            },
            yaml = {{lintCommand = "yamllint -f parsable -", lintStdin = true}},
            python = {
                {
                    lintCommand = "flake8 --stdin-display-name ${INPUT} -",
                    lintStdin = true,
                    lintFormats = {"%f:%l:%c: %m"}
                }, {formatCommand = "autopep8 -", formatStdin = true}
            },
            vim = {
                {
                    lintCommand = "vint -",
                    lintStdin = true,
                    lintFormats = {"%f:%l:%c: %m"}
                }
            },
            cpp = {{formatCommand = "clang-format", formatStdin = true}},
            json = {
                {lintCommand = "jq ."},
                {formatCommand = "prettier --parser json", formatStdin = true}
            }
        }
    }
}

lspconfig.setup_servers = function()
    local lspinstall = require('lspinstall')
    lspinstall.setup()

    local servers = lspinstall.installed_servers()

    for _, server in pairs(servers) do
        local config = make_config()

        if server == "lua" then
            local luadev = require('lua-dev').setup({})

            config = tableMerge(config, luadev)
        end

        if server == "vim" then config.init_options = {isNeovim = true} end

        if server == "efm" then config = tableMerge(config, efm_config) end

        require('lspconfig')[server].setup(config)
    end
end

return lspconfig
