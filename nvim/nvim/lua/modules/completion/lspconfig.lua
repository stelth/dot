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
                l = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Folders" }
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
        t = { "<cmdlua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" }
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

    setup_keymaps(client, bufnr)
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

    -- install_servers()

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
