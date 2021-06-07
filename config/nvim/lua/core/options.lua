local global = require('core.global')

local function bind_option(options)
    for k, v in pairs(options) do vim.opt[k] = v end
end

local function load_options()
    local options = {
        termguicolors = true,
        mouse = "nv",
        errorbells = true,
        visualbell = true,
        hidden = true,
        fileformats = {"unix", "mac", "dos"},
        magic = true,
        virtualedit = "block",
        encoding = "utf-8",
        viewoptions = {"folds", "cursor", "curdir", "slash", "unix"},
        sessionoptions = {"curdir", "help", "tabpages", "winsize"},
        clipboard = "unnamedplus",
        wildignorecase = true,
        wildignore = {
            ".git", ".hg", ".svn", "*.pyc", "*.o", "*.out", "*.jpg", "*.jpeg",
            "*.png", "*.gif", "*.zip", "**/tmp/**", "*.DS_Store",
            "**/node_modules/**", "**/bower_modules/**"
        },
        backup = false,
        writebackup = false,
        swapfile = false,
        directory = global.cache_dir .. "swap/",
        undodir = global.cache_dir .. "undo/",
        backupdir = global.cache_dir .. "backup/",
        viewdir = global.cache_dir .. "view/",
        spellfile = global.cache_dir .. "spell/en.utf-8.add",
        history = 2000,
        shada = {"!", "'300", "<50", "@100", "s10", "h"},
        backupskip = {
            "/tmp/*", "$TMPDIR/*", "$TMP/*", "$TEMP/*", "*/shm/*",
            "/private/var/*", ".vault.vim"
        },
        smarttab = true,
        shiftround = true,
        timeout = true,
        ttimeout = true,
        timeoutlen = 500,
        ttimeoutlen = 10,
        updatetime = 100,
        redrawtime = 1500,
        ignorecase = true,
        smartcase = true,
        infercase = true,
        incsearch = true,
        wrapscan = true,
        complete = {".", "w", "b", "k"},
        inccommand = "nosplit",
        grepformat = "%f:%l:%c:%m",
        grepprg = 'rg --hidden --vimgrep --smart-case --',
        breakat = [[\ \	;:,!?]],
        startofline = false,
        whichwrap = "h,l,<,>,[,],~",
        splitbelow = true,
        splitright = true,
        switchbuf = "useopen",
        backspace = {"indent", "eol", "start"},
        diffopt = {"filler", "iwhite", "internal", "algorithm:patience"},
        completeopt = {"menuone", "noselect", "noinsert"},
        jumpoptions = "stack",
        showmode = false,
        shortmess = "aoOTIcF",
        scrolloff = 2,
        sidescrolloff = 5,
        foldlevelstart = 99,
        ruler = false,
        list = true,
        showtabline = 2,
        winwidth = 30,
        winminwidth = 10,
        pumheight = 15,
        helpheight = 12,
        previewheight = 12,
        showcmd = false,
        cmdheight = 2,
        cmdwinheight = 5,
        equalalways = false,
        laststatus = 2,
        display = "lastline",
        listchars = {
            tab = "»·",
            nbsp = "+",
            trail = "·",
            extends = "→",
            precedes = "←"
        },
        showbreak = "↳  ",
        pumblend = 10,
        winblend = 10,
        undofile = true,
        synmaxcol = 2500,
        formatoptions = "1jcroql",
        textwidth = 80,
        expandtab = true,
        autoindent = true,
        tabstop = 4,
        shiftwidth = 4,
        softtabstop = -1,
        breakindentopt = {shift = 4, min = 20},
        wrap = false,
        linebreak = true,
        number = true,
        colorcolumn = "80",
        foldenable = true,
        signcolumn = "yes",
        conceallevel = 2,
        concealcursor = "niv"
    }
    bind_option(options)

    if global.is_mac then
        vim.g.clipboard = {
            name = "macOS-clipboard",
            copy = {["+"] = "pbcopy", ["*"] = "pbcopy"},
            paste = {["+"] = "pbpaste", ["*"] = "pbpaste"},
            cache_enabled = 0
        }
        vim.g.python3_host_prog = '/usr/local/bin/python3'
    else
        vim.g.python3_host_prog = '/usr/bin/python3'
    end
end

load_options()
