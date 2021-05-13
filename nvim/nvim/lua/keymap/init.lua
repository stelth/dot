local wk = require("which-key")

local normal_leader = {
    ["w"] = {
        name = "+Windows",
        ["w"] = { "<C-W>p", "other-window" },
        ["d"] = { "<C-W>c", "delete-window" },
        ["-"] = { "<C-W>s", "split-window-below" },
        ["|"] = { "<C-W>v", "split-window-right" },
        ["2"] = { "<C-W>v", "layout-double-columns" },
        ["h"] = { "<C-W>h", "window-left" },
        ["j"] = { "<C-W>j", "window-below" },
        ["k"] = { "<C-W>k", "window-right" },
        ["l"] = { "<C-W>l", "window-up" },
        ["H"] = { "<C-W>5<", "expand-window-left" },
        ["J"] = { "<cmd>resize +5<CR>", "expand-window-below" },
        ["L"] = { "<C-W>5>", "expand-window-right" },
        ["K"] = { "<cmd>resize -5<CR>", "expand-window-up" },
        ["="] = { "<C-W>=", "balance-window" },
        ["s"] = { "<C-W>s", "split-window-below" },
        ["v"] = { "<C-W>v", "split-window-right" }
    },
    c = {
        v = { "<cmd>Vista!!<CR>", "Vista" }
    },
    b = {
        name = "+Buffer",
        b = { "<cmd>e #<CR>", "Switch to other buffer" },
        p = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
        n = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
        d = { "<cmd>bd<CR>", "Delete Buffer" },
        g = { "<cmd>BufferLinePick<CR>", "Goto Buffer" }
    },
    g = {
        name = "+Git",
        c = { "<cmd>Telescope git_commits<CR>", "commits" },
        b = { "<cmd>Telescope git_branches<CR>", "branches" },
        s = { "<cmd>Telescope git_status<CR>", "status" },
        f = { "<cmd>Telescope git_files<CR>", "files" },
        h = {
            name = "+Hunk",
            n = { "<cmd>lua require('gitsigns').next_hunk()<CR>", "Next Hunk" },
            p = { "<cmd>lua require('gitsigns').prev_hunk()<CR>", "Previous Hunk" },
            s = { "<cmd>lua require('gitsigns').stage_hunk()<CR>", "Stage Hunk" },
            u = { "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>", "Undo Stage Hunk" },
            r = { "<cmd>lua require('gitsigns').reset_hunk()<CR>", "Reset Hunk" },
            v = { "<cmd>lua require('gitsigns').preview_hunk()<CR>", "View Hunk" },
            b = { "<cmd>lua require('gitsigns').blame_line()<CR>", "Blame" }
        }
    },
    h = {
        name = "+Help",
        t = { "<cmd>Telescope builtin<CR>", "Telescope" },
        c = { "<cmd>Telescope commands<CR>", "Commands" },
        h = { "<cmd>Telescope help_tags<CR>", "Help Pages" },
        m = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
        k = { "<cmd>Telescope keymaps<CR>", "Key Maps" },
        s = { "<cmd>Telescope highlights<CR>", "Search Highlight Groups" },
        l = { [[<cmd>TSHighlightCapturesUnderCursor<CR>]], "Highlight Groups at Cursor" },
        f = { "<cmd>Telescope filetypes<CR>", "File Types" },
        o = { "<cmd>Telescope vim_options<CR>", "Options" },
        a = { "<cmd>Telescope autocommands<CR>", "Auto Commands" },
        p = {
            name = "+Packer",
            p = { "<cmd>PackerSync<CR>", "Sync" },
            s = { "<cmd>PackerStatus<CR>", "Status" },
            i = { "<cmd>PackerInstall<CR>", "Install" },
            c = { "<cmd>PackerCompile<CR>", "Compile" },
            u = { "<cmd>PackerUpdate<CR>", "Update" },
            r = { "<cmd>PackerClean<CR>", "Clean" }
        }
    },
    s = {
        name = "+Search",
        g = { "<cmd>Telescope live_grep<CR>", "Grep" },
        b = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Buffer" },
        s = { "<cmd>Telescope lsp_document_symbols<CR>", "Goto Symbol" },
        h = { "<cmd>Telescope command_history<CR>", "Command History" },
        m = { "<cmd>Telescope marks<CR>", "Jump to Mark" },
        l = { "<cmd>Telescope loclist<CR>", "Location List" }
    },
    f = {
        name = "+File",
        t = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
        f = { "<cmd>Telescope find_files<CR>", "Find File" },
        r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
        n = { "<cmd>enew<CR>", "New File" },
        d = { "<cmd>Telescope dotfiles path=" .. os.getenv("HOME") .. "/dotfiles<CR>", "Dot Files" }
    },
    t = {
        name = "+Tabs",
        t = { "<cmd>tabnew<CR>", "New Tab" },
        n = { "<cmd>tabnext<CR>", "Next" },
        d = { "<cmd>tabclose<CR>", "Close" },
        p = { "<cmd>tabprevious<CR>", "Previous" },
        f = { "<cmd>tabfirst<CR>", "First" },
        l = { "<cmd>tablast<CR>", "Last" }
    },
    ["."] = { "<cmdTelescope file_browser<CR>", "Browse Files" },
    [","] = { "<cmd>Telescope buffers show_all_buffers=true<CR>", "Switch Buffer" },
    ["/"] = { "<cmd>Telescope live_grep<CR>", "Search" },
    [":"] = { "<cmd>Telescope command_history<CR>", "Command History" },
    ["n"] = { "<cmd>execute('normal! ' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>", "Next" },
    ["N"] = { "<cmd>execute('normal! ' . v:count1 . 'N')<CR><cmd>lua require('hlslens').start()<CR>", "Previous" },
    ["*"] = { "*<cmd>lua require('hlslens').start()<CR>", "Start search forwards" },
    ["#"] = { "#<cmd>lua require('hlslens').start()<CR>", "Start search backwards" },
    ["g*"] = { "g*<cmd>lua require('hlslens').start()<CR>", "Start search global" },
    ["g#"] = { "g#<cmd>lua require('hlslens').start()<CR>", "Start search global" },
    [" "] = { "<cmd>lua require('FTerm').toggle()<CR>", "Toggle Terminal" },
    x = {
        name = "+Errors",
        x = { "<cmd>LspTroubleToggle<CR>", "Trouble" },
        w = { "<cmd>LspTroubleWorkspaceToggle<CR>", "Workspace Trouble" },
        d = { "<cmd>LspTroubleDocumentToggle<CR>", "Document Trouble" },
        l = { "<cmd>lopen<CR>", "Open Location List" },
        q = { "<cmd>copen<CR>", "Open Quickfix List" }
    }
}

for i = 0, 10 do
    normal_leader[tostring(i)] = "which_key_ignore"
end

local no_leader = {
    ["<BS>"] = { ":noh<CR>", "No Highlight" }
}

local terminal_mapping = {
    [" "] = { "<cmd>lua require('FTerm').toggle()<CR>", "Toggle Terminal" }
}

wk.register( normal_leader, { prefix = "<leader>" } )
wk.register( no_leader )
wk.register( terminal_mapping, { prefix = "<leader>", mode = "t" } )
