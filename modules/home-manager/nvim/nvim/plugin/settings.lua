-- ----------------------------------
-- General Settings
-- ----------------------------------
local indent = 2
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.autowrite = true -- enable auto write
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.cmdheight = 0 -- hide cmdline on the bottom
vim.opt.concealcursor = "n" -- Hide * markup for bold and italic
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr" -- Use expression to determine folding
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.guifont = "FiraCode Nerd Font:h12"
vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.hlsearch = false -- Don't highlight search terms
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.laststatus = 3 -- Global statusline
vim.opt.list = false -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = indent -- Size of an indent
vim.opt.showmode = false -- dont show mode since we have a statusline
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true -- Don't ignore case with capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.tabstop = indent -- Number of spaces tabs count for
vim.opt.termguicolors = true -- True color support
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200 -- save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.wrap = false -- Disable line wrap

-- don't load the plugins below
vim.g.did_load_filetypes = 0
vim.g.loaded_2html_plugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1

vim.g.do_filetype_lua = 1

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "Visual",
      timeout = "120",
    })
  end,
})

local warn = function(msg, name)
  vim.notify(msg, vim.log.levels.WARN, { title = name })
end

local info = function(msg, name)
  vim.notify(msg, vim.log.levels.INFO, { title = name })
end

local toggle = function(option, silent)
  local option_info = vim.api.nvim_get_option_info(option)
  local scopes = { buf = "bo", win = "wo", global = "o" }
  local scope = scopes[option_info.scope]
  local options = vim[scope]
  options[option] = not options[option]
  if silent ~= true then
    if options[option] then
      info("enabled vim." .. scope .. "." .. option, "Toggle")
    else
      warn("disabled vim." .. scope .. "." .. option, "Toggle")
    end
  end
end

-- ----------------------------------
-- Key maps
-- ----------------------------------

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", '"_dp')
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y"')
vim.keymap.set("n", "<leader>Y", '"+Y"')

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d"')

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u", {})
vim.keymap.set("i", ".", ".<c-g>u", {})
vim.keymap.set("i", ";", ";<c-g>u", {})

-- better indenting
vim.keymap.set("v", "<", "<gv", {})
vim.keymap.set("v", ">", ">gv", {})

-- Toggle
vim.keymap.set("n", "<leader>ts", "", {
  callback = function()
    toggle("spell")
  end,
  desc = "Toggle Spell",
})
vim.keymap.set("n", "<leader>tw", "", {
  callback = function()
    toggle("wrap")
  end,
  desc = "Toggle Wrap",
})
vim.keymap.set("n", "<leader>tn", "", {
  callback = function()
    toggle("relativenumber", true)
    toggle("number")
  end,
  desc = "Toggle Line Numbers",
})

vim.keymap.set("n", "<C-f>", ":silent !tmux neww tmux-sessionizer<CR>", {
  silent = true,
  desc = "New tmux-sessionizer window",
})
