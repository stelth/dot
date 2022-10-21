local wk = require("which-key")
local utils = require("utils")

vim.o.timeoutlen = 300

wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

vim.keymap.set("n", "<C-k>", vim.cmd.cnext)
vim.keymap.set("n", "<C-j>", vim.cmd.cprev)
vim.keymap.set("n", "<leader>k", vim.cmd.lnext)
vim.keymap.set("n", "<leader>j", vim.cmd.lprev)

vim.keymap.set("", "<ESC>", ":noh<ESC>")

local leader = {
  w = {
    name = "+window",
    w = { "<C-W>p", "Other Window" },
    d = { "<C-W>d", "Delete Window" },
    ["-"] = { "<C-W>s", "Split Window Below" },
    ["|"] = { "<C-W>v", "Split Window Right" },
    h = { "<C-W>h", "Window Left" },
    j = { "<C-W>j", "Window Below" },
    k = { "<C-W>k", "Window Up" },
    l = { "<C-W>l", "Window Right" },
    H = { "<C-W>5<", "Expand Window Left" },
    J = { ":resize +5", "Expand Window Below" },
    K = { ":resize -5", "Expand Window Up" },
    L = { "<C-W>5>", "Expand Window Right" },
    ["="] = { "<C-W>=", "Balance Window" },
  },
  c = {
    name = "+code",
  },
  g = {
    name = "+git",
    c = { "<cmd>Telescope git_commits<cr>", "Commits" },
    b = { "<cmd>Telescope git_branches<cr>", "Branches" },
    s = { "<cmd>Telescope git_status<cr>", "Status" },
    d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
  },
  h = {
    name = "+help",
    t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
    c = { "<cmd>:Telescope commands<cr>", "Commands" },
    h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
    m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
    k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
    s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
    f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
    o = { "<cmd>:Telescope vim_options<cr>", "Options" },
    a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
  },
  s = {
    name = "+search",
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
    h = { "<cmd>Telescope command_history<cr>", "Command History" },
    m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
    w = {
      function()
        require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
      end,
      "Current Word",
    },
  },
  f = {
    name = "+file",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  },
  t = {
    name = "+toggle",
    f = {
      require("plugins.lsp.formatting").toggle_formatting,
      "Format on Save",
    },
    s = {
      function()
        utils.toggle("spell")
      end,
      "Spelling",
    },
    w = {
      function()
        utils.toggle("wrap")
      end,
      "Word Wrap",
    },
    n = {
      function()
        utils.toggle("relativenumber")
        utils.toggle("number")
      end,
      "Line Numbers",
    },
  },
  ["."] = { "<cmd>Telescope file_browser<cr>", "Browse Files" },
  [","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch buffer" },
  ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
  [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
  x = {
    name = "+errors",
    l = { "<cmd>lopen<cr>", "Open Location List" },
    q = { "<cmd>copen<cr>", "Open Quickfix List" },
  },
  z = { "<cmd>ZenMode<cr>", "Zen Mode" },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })
wk.register({ g = { name = "+goto" } })
