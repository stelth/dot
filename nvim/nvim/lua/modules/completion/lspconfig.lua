local api = vim.api
local format = require('modules.completion.format')

local lspconfig = {}

if not packer_plugins['lspsaga.nvim'].loaded then
    vim.cmd [[packadd lspsaga.nvim]]
end

local saga = require 'lspsaga'
saga.init_lsp_saga({
    code_action_icon = '💡'
})

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

local function setup_keymaps(client, bufnr)
    local keymap = {
        c = {
            name = "+Code",
            r = { "<cmd>lua require('lspsaga.rename').rename()<CR>", "Rename" },
            a = { "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", "Code Action" },
            d = { "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>", "Line Diagnostics" },
            l = {
                name = "+LSP",
                i = { "<cmd>LspInfo<CR>", "LSP Info" },
                a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Folder" },
                r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Folder" },
                l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Folders" },
                c = { "<cmd>lua require('modules.completion.lsp-capabilities')()<CR>", "List Capabilities" }
            }
        },
        x = {
            s = { "<cmd>Telescope lsp_document_diagnostics<CR>", "Search Document Diagnostics" },
            w = { "<cmd>Telescope lsp_workspace_diagnostics<CR>", "Workspace Diagnostics" }
        }
    }

    local keymap_visual = {
        c = {
            name = "+Code",
            a = { "<cmd><C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", "Code Action" }
        }
    }

    local keymap_goto = {
        name = "+Goto",
        r = { "<cmd>Telescope lsp_references<CR>", "References" },
        R = { "<cmd>LspTrouble lsp_references<CR>", "Trouble References" },
        D = { "<cmd>lua require('lspsaga.provider').preview_definition()<CR>", "Peek Definition" },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
        s = { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", "Signature Help" },
        I = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Goto Implementation" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" }
    }

    local keymap_no_leader = {
        K = { "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", "" },
        ["<CR>"] = { "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", "" },
        ["[d"] = { "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>", "" },
        ["]d"] = { "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>", "" }
    }

    if client.resolved_capabilities.document_formatting then
        keymap.c.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
    elseif client.resolved_capabilities.document_range_formatting then
        keymap_visual.c.f = { "<cmd>lua vim.lsp.buf.ranve_formatting()<CR>", "Format Range" }
    end

    local wk = require('which-key')

    wk.register( keymap, { buffer = bufnr, prefix = "<leader>" })
    wk.register( keymap_no_leader, { buffer = bufnr })
    wk.register( keymap_visual, { buffer = bufnr, prefix = "<leader>", mode = "v" })
    wk.register( keymap_goto, { buffer = bufnr, prefix = "g" })
end

local enhance_attach = function(client, bufnr)
    local completion = require('completion')
    completion.on_attach()
    if client.resolved_capabilities.document_formatting then
        format.lsp_before_save()
    end
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    require('lsp_signature').on_attach({
        bind = true,
        doc_lines = 10,
        hint_enable = true,
        hint_prefix = "🐼 ",
        hint_scheme = "String",
        use_lspsaga = true,
        handler_opts = {
            border = "shadow"
        },
        decorator = {"`", "`"}
    })

    setup_keymaps(client, bufnr)
end

local function make_config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    return {
        capabilities = capabilities,
        on_attach = enhance_attach
    }
end

lspconfig.install_servers = function()
    local required_servers = { "bash", "cmake", "cpp", "latex", "lua", "python", "vim", "yaml" }
    local installed_servers = require('lspinstall').installed_servers()

    for _, server in pairs( required_servers ) do
        if not vim.tbl_contains( installed_servers, server ) then
            require('lspinstall').install_server( server )
        end
    end
end

local function tableMerge(t1, t2)
    for k,v in pairs(t2) do
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

lspconfig.setup_servers = function()
    local lspinstall = require('lspinstall')
    lspinstall.setup()

    local servers = lspinstall.installed_servers()

    for _, server in pairs( servers ) do
        local config = make_config()

        if server == "lua" then
            local luadev = require('lua-dev').setup({})

            config = tableMerge(config, luadev)
        end

        if server == "vim" then
            config.init_options = { isNeovim = true }
        end

        require('lspconfig')[server].setup(config)
    end
end

return lspconfig
