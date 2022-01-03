pcall(require, "packer_compiled")
local util = require("util")

-- ----------------------------------
-- General Seeettings
-- ----------------------------------
local indent = 2
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.autowrite = true -- enable auto write
vim.opt.clipboard = "unnamedplus" -- sync with system clipboard
vim.opt.conceallevel = 2 -- Hide * markup for bold and italic
vim.opt.concealcursor = "n" -- Hide * markup for bold and italic
vim.opt.confirm = true -- confirm to save changes before exiting modified buffer
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.guifont = "FiraCode Nerd Font:h12"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.hidden = true -- Enable modified buffers in background
vim.opt.ignorecase = true -- Ignore case
vim.opt.inccommand = "split" -- preview incremental substitute
vim.opt.joinspaces = false -- No double spaces with join after a dot
vim.opt.list = true -- Show some invisible characters (tabs...
vim.opt.mouse = "a" -- enable mouse mode
vim.opt.number = true -- Print line number
vim.opt.pumblend = 10 -- Popup blend
vim.opt.pumheight = 10 -- Maximum number of entries in a popup
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.scrolloff = 4 -- Lines of context
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
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

-- don't load the plugins below
vim.g.loaded_gzip = 1
vim.g.loaded_fzf = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

local cmd = vim.cmd
local au = require("util.au")

-- go to last loc when opening a buffer
au.BufReadPost = {
  "*",
  function()
    if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.execute('normal! g`"')
    end
  end,
}

-- Highlight on yank
au.TextYankPost = function()
  vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
end

-- ----------------------------------
-- Key maps
-- ----------------------------------

-- Quit shortcuts
util.nnoremap("<leader>qq", ":qa<CR>")
util.nnoremap("<leader>q!", ":qa!<CR>")

-- Add undo break-points
util.inoremap(",", ",<c-g>u")
util.inoremap(".", ".<c-g>u")
util.inoremap(";", ";<c-g>u")

-- better indenting
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")

-- New file
util.nnoremap("<leader>fn", ":enew<CR>")

-- Toggle
util.nnoremap("<leader>ts", ":lua require('util').toggle('spell')<CR>")
util.nnoremap("<leader>tw", ":lua require('util').toggle('wrap')<CR>")
util.nnoremap("<leader>tn", ":lua require('util').toggle('relativenumber', true); require('util').toggle('number')<CR>")

-- Quickfix and Location List mappings
util.nnoremap("<leader>xl", ":lopen<CR>")
util.nnoremap("<leader>xq", ":copen<CR>")

util.nnoremap("<leader>cu", function()
  local number = math.random(math.pow(2, 127) + 1, math.pow(2, 128))
  return "i" .. string.format("%.0f", number)
end, {
  expr = true,
})

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
  [[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
  false
)

require("plugins")
