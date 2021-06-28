local indent = 2
local global = require("global")

local function bind_option(options)
  for k, v in pairs(options) do
    vim.opt[k] = v
  end
end

local function load_options()
  local options = {
    autoindent = true,
    backspace = { "indent", "eol", "start" },
    backupdir = global.cache_dir .. "backup/",
    backup = false,
    backupskip = { "/tmp/*", "$TMPDIR/*", "$TMP/*", "$TEMP/*", "*/shm/*", "/private/var/*", ".vault.vim" },
    breakat = [[\ \	;:,!?]],
    breakindentopt = { shift = 4, min = 20 },
    clipboard = "unnamedplus",
    cmdheight = 2,
    cmdwinheight = 5,
    colorcolumn = "80",
    completeopt = { "menuone", "noselect", "noinsert" },
    complete = { ".", "w", "b", "k" },
    concealcursor = "niv",
    conceallevel = 2,
    confirm = true,
    cursorline = true,
    diffopt = { "filler", "iwhite", "internal", "algorithm:patience" },
    directory = global.cache_dir .. "swap/",
    display = "lastline",
    encoding = "utf-8",
    equalalways = false,
    errorbells = true,
    expandtab = true,
    fileformats = { "unix", "mac", "dos" },
    foldenable = true,
    foldexpr = "nvim_treesitter#foldexpr()",
    foldlevel = 6,
    foldlevelstart = 99,
    formatoptions = "1jcroql",
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --hidden --vimgrep --smart-case --",
    helpheight = 12,
    hidden = true,
    history = 2000,
    ignorecase = true,
    inccommand = "split",
    incsearch = true,
    infercase = true,
    joinspaces = false,
    jumpoptions = "stack",
    laststatus = 2,
    linebreak = true,
    listchars = { tab = "»·", nbsp = "+", trail = "·", extends = "→", precedes = "←" },
    list = true,
    magic = true,
    mouse = "a",
    number = true,
    previewheight = 12,
    pumblend = 10,
    pumheight = 10,
    redrawtime = 1500,
    relativenumber = true,
    ruler = false,
    scrolloff = 4,
    sessionoptions = { "curdir", "help", "tabpages", "winsize" },
    shada = { "!", "'300", "<50", "@100", "s10", "h" },
    shiftround = true,
    shiftwidth = indent,
    shortmess = "aoOTIcF",
    showbreak = "↳  ",
    showcmd = false,
    showmode = false,
    showtabline = 2,
    sidescrolloff = 8,
    signcolumn = "yes",
    smartcase = true,
    smartindent = true,
    smarttab = true,
    softtabstop = -1,
    spellfile = global.cache_dir .. "spell/en.utf-8.add",
    splitbelow = true,
    splitright = true,
    startofline = false,
    swapfile = false,
    switchbuf = "useopen",
    synmaxcol = 2500,
    tabstop = indent,
    termguicolors = true,
    textwidth = 80,
    timeoutlen = 100,
    timeout = true,
    ttimeoutlen = 10,
    ttimeout = true,
    undodir = global.cache_dir .. "undo/",
    undofile = true,
    undolevels = 10000,
    updatetime = 200,
    viewdir = global.cache_dir .. "view/",
    viewoptions = { "folds", "cursor", "curdir", "slash", "unix" },
    virtualedit = "block",
    visualbell = true,
    whichwrap = "h,l,<,>,[,],~",
    wildignorecase = true,
    wildignore = {
      ".git",
      ".hg",
      ".svn",
      "*.pyc",
      "*.o",
      "*.out",
      "*.jpg",
      "*.jpeg",
      "*.png",
      "*.gif",
      "*.zip",
      "**/tmp/**",
      "*.DS_Store",
      "**/node_modules/**",
      "**/bower_modules/**",
    },
    wildmode = "longest:full,full",
    winblend = 10,
    winminwidth = 10,
    winwidth = 30,
    wrap = false,
    wrapscan = true,
    writebackup = false,
  }
  bind_option(options)

  if global.is_mac then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
      paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
      cache_enabled = 0,
    }
    vim.g.python3_host_prog = "/usr/local/bin/python3"
  else
    vim.g.python3_host_prog = "/usr/bin/python3"
  end

  -- show cursor line only in active window
  vim.cmd([[
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
  ]])

  -- go to last location when opening a buffer
  vim.cmd([[
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  ]])

  -- Highlight on yank
  vim.cmd("au TextYankPost * lua vim.highlight.on_yank {}")
end

load_options()
