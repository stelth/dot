local api = vim.api
local format = require('modules.completion.format')

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

local function setup_lsp_keymaps(client, bufnr)
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
                c = { "<cmd>lua require('modules.completion.lsp-capabilities').list_lsp_capabilities()<CR>", "List Capabilities" }
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

    local compe_confirm = {
        ["<CR>"] = { [[compe#confirm('<CR>')]], "Confirm Completion" }
    }

    if client.resolved_capabilities.document_formatting then
        keymap.c.f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
    elseif client.resolved_capabilities.document_range_formatting then
        keymap_visual.c.f = { "<cmd>lua vim.lsp.buf.range_formatting()<CR>", "Format Range" }
    end

    local wk = require('which-key')

    wk.register( keymap, { buffer = bufnr, prefix = "<leader>" })
    wk.register( keymap_no_leader, { buffer = bufnr })
    wk.register( keymap_visual, { buffer = bufnr, prefix = "<leader>", mode = "v" })
    wk.register( keymap_goto, { buffer = bufnr, prefix = "g" })
    wk.register( compe_confirm, { mode = "i", expr = true, noremap = true })
end

local function setup_treesitter_textobjects(bufnr)
    local wk = require('which-key')

    local selection_operator_keymap = {
        ["af"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@function.outer', 'o')<CR>", "Select outer function" },
        ["if"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@function.inner', 'o')<CR>", "Select inner function" },
        ["ac"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@class.outer', 'o')<CR>", "Select outer class" },
        ["ic"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@class.inner', 'o')<CR>", "Select inner class" }
    }
    wk.register(selection_operator_keymap, { buffer = bufnr, mode = "o", noremap = true, silent = true })

    local selection_operator_keymap_visual = {
        ["af"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@function.outer', 'x')<CR>", "Select outer function" },
        ["if"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@function.inner', 'x')<CR>", "Select inner function" },
        ["ac"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@class.outer', 'x')<CR>", "Select outer class" },
        ["ic"] = { "<cmd>lua require('nvim-treesitter.textobjects.select').select_textobject('@class.inner', 'x')<CR>", "Select inner class" }
    }
    wk.register(selection_operator_keymap_visual, { buffer = bufnr, mode = "x", noremap = true, silent = true })

    local move_operator_keymap = {
        ["]m"] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_next_start('@function.outer')<CR>", "Goto next function start" },
        ["]]"] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_next_start('@class.outer')<CR>", "Goto next class start" },
        ["]M"] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_next_end('@function.outer'<CR>", "Goto next function end" },
        ["]["] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_next_end('@class.outer'<CR>", "Goto next class end" },
        ["[m"] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_previous_start('@function.outer')<CR>", "Goto previous function start" },
        ["[["] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_previous_start('@class.outer')<CR>", "Goto previous class start" },
        ["[M"] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_previous_end('@function.outer')<CR>", "Goto previous function end" },
        ["[]"] = { "<cmd>lua require('nvim-treesitter.textobjects.move').goto_previous_end('@class.outer')<CR>", "Goto previous class end" }
    }
    wk.register(move_operator_keymap, { buffer = bufnr, mode = "o", noremap = true, silent = true })

    local swap_operator_keymap = {
        c = {
            s = {
                name = "+Swap",
                p = {
                    name = "+Parameter",
                    a = { "<cmd>lua require('nvim-treesitter.textobjects.swap').swap_next('@parameter.inner')<CR>", "Swap next parameter" },
                    A = { "<cmd>lua require('nvim-treesitter.textobjects.swap').swap_previous('@parameter.inner')<CR>", "Swap previous parameter" }
                }
            }
        }
    }
    wk.register(swap_operator_keymap, { prefix = "<leader>", buffer = bufnr, noremap = true, silent = true})
end

local function setup_treesitter_playground_keymaps(bufnr)
    local wk = require('which-key')

    local playground_keymap = {
        u = {
            p = { "<cmd>TSPlaygroundToggle<CR>", "Treesitter Playground" }
        }
    }
    wk.register(playground_keymap, { prefix = "<leader>", buffer = bufnr, noremap = true, silent = true})
end

local function setup_keymaps(client, bufnr)
    setup_lsp_keymaps(client, bufnr)
    setup_treesitter_textobjects(bufnr)
    setup_treesitter_playground_keymaps(bufnr)
end

local enhance_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
        format.lsp_before_save()
    end
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local saga = require('lspsaga')
    saga.init_lsp_saga({
        code_action_icon = '💡'
    })

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
        use_lspsaga = true
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
