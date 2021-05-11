local wk = require("which-key")

-- Vista plugin keymap
wk.register({
    v = { "<cmd>Vista<CR>", "Vista" }
}, { prefix = "<leader>" } )

-- BufferLine plugin keymap
wk.register({
    g = {
        name = "Buffer Line",
        b = { "<cmd>BufferLinePick<CR>", "Pick Buffer" }
    }
}, { nowait = true } )

-- Packer keymap
wk.register({
    p = {
        name = "+Packer",
        u = { "<cmd>PackerUpdate<CR>", "Update Plugins" },
        i = { "<cmd>PackerInstall<CR>", "Install Plugins" },
        c = { "<cmd>PackerCompile<CR>", "Compile Config" }
    }
}, { prefix = "<leader>", nowait = true } )

-- lsp keymap
wk.register({
    l = {
        name = "+LSP",
        i = {"<cmd>LspInfo<CR>", "LSP Info" },
        l = {"<cmd>LspLog<CR>", "LSP Log" },
        r = {"<cmd>LspRestart<CR>", "LSP Restart" }
    }
}, { prefix = "<leader>", nowait = true } )

-- Lspsaga smart scroll mappings
wk.register({
    [""] = { name = "+lspsaga scroll" },
    ["<C-f>"] = { "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", "lspsaga smart scroll forward" },
    ["<C-b>"] = { "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", "lspsaga smart scroll backwards" }
}, { nowait = true })

-- Lspsaga "goto" shortcuts
wk.register({
    g = {
        name = "+Lspsaga 'goto'",
        a = { "<cmd>Lspsaga code_action<CR>", "Code Action" },
        d = { "<cmd>Lspsaga preview_definition<CR>", "Definition Preview" },
        D = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
        s = { "<cmd>Lspsaga signature_help<CR>", "Signature" },
        r = { "<cmd>Lspsaga rename<CR>", "Rename" },
        h = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
        t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type Definition" }
    },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "Show Documentation" },
    ["[e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
    ["]e"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Prev Diagnostic" },
    ["<leader>ce"] = { "<cmd>Lspsaga show_line_diagnostics<CR>", "Show Line Diagnostics" }
})

-- Lspsaga ranged shortcut
wk.register({
    g = {
        a = { "<cmd>Lspsaga range_code_action<CR>", "Ranged Code Action" }
    }
}, { mode = "v" })

-- Dashboard key mappings
wk.register({
    t = {
        name = "+Dashboard",
        f = { "<cmd>DashboardNewFile<CR>", "New File" }
    }
}, { prefix = "<leader>" })

-- nvim-tree mappings
wk.register({
    e = { "<cmd>NvimTreeToggle<CR>", "Toggle File Explorer" },
}, { prefix = "<leader>" })

-- Telescope mappings
wk.register({
    f = {
        name = "+Telescope",
        a = { "<cmd>DashboardFindWord<CR>", "Find Word" },
        b = { "<cmd>Telescope file_browser<CR>", "File Browser" },
        f = { "<cmd>DashboardFindFile<CR>", "Find File" },
        g = { "<cmd>Telescope git_files<CR>", "Find git files" },
        w = { "<cmd>Telescope grep_string<CR>", "Grep for string" },
        h = { "<cmd>DashboardFindHistory<CR>", "Find History" },
        l = { "<cmd>Telescope loclist<CR>", "Location List" },
        c = { "<cmd>Telescope git_commits<CR>", "Git Commits" },
        t = { "<cmd>Telescope help_tags<CR>", "Help Tags" },
        d = { "<cmd>Telescope dotfiles path=" .. os.getenv("HOME") .. "/dotfiles<CR>", "Find Dotfile" }
    },
    b = {
        name = "+Telescope",
        b = { "<cmd>Telescope buffers<CR>", "Find buffer" }
    }
}, { prefix = "<leader>" })

-- QuickRun mappings
wk.register({
    r = {"<cmd>lua require('internal.quickrun').run_command()<CR>", "Run Command" }
}, { prefix = "<leader>" })

-- nvim-hlslens mapping
wk.register({
    ["n"] = { "<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>", "Next" },
    ["N"] = { "<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>", "Previous" },
    ["*"] = { "*<Cmd>lua require('hlslens').start()<CR>", "Start search forwards" },
    ["#"] = { "#<Cmd>lua require('hlslens').start()<CR>", "Start search backwards" },
    ["g*"] = { "g*<Cmd>lua require('hlslens').start()<CR>", "Start search global" },
    ["g#"] = { "g#<Cmd>lua require('hlslens').start()<CR>", "Start search global" }
})

-- FTerm toggle
wk.register({
    ["sh"] = { "<Cmd>lua require('FTerm').toggle()<CR>", "Toggle Terminal" }
}, { prefix = "<leader>" })

-- FTerm toggle
wk.register({
    ["sh"] = { "<Cmd>lua require('FTerm').toggle()<CR>", "Toggle Terminal" }
}, { prefix = "<leader>", mode = "t" })
