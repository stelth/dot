local wk = require("which-key")
local util = require("util")
local telescope_builtin = require("telescope.builtin")

vim.o.timeoutlen = 300

wk.setup({
  show_help = false,
  triggers = "auto",
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
})

-- Make all keymaps silent by default
local keymap_set = vim.keymap.set
vim.keymap.set = function(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  return keymap_set(mode, lhs, rhs, opts)
end

local keymaps = {
  {
    Y = { "yg$", "" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    [","] = { ",<c-g>u", "", mode = "i" },
    ["."] = { ".<c-g>u", "", mode = "i" },
    [";"] = { ";<c-g>u", "", mode = "i" },
    ["<"] = { "<gv", "", mode = "v" },
    [">"] = { ">gv", "", mode = "v" },
    n = {
      expr = true,
      { "'Nn'[v:searchforward]", "", mode = { "n", "x", "o" } },
    },
    N = {
      expr = true,
      { "'nN'[v:searchforward]", "", mode = { "n", "x", "o" } },
    },
    ["<C-k>"] = { vim.cmd.cnext, "" },
    ["<C-j>"] = { vim.cmd.cprev, "" },
    ["<BS>"] = { vim.cmd.nohlsearch, "" },
  },
  {
    prefix = "<leader>",
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
      J = { ":resize +5<cr>", "Expand Window Below" },
      K = { ":resize -5<cr>", "Expand Window Up" },
      L = { "<C-W>5>", "Expand Window Right" },
      ["="] = { "<C-W>=", "Balance Window" },
    },
    c = {
      name = "+code",
    },
    g = {
      name = "+git",
      c = { telescope_builtin.git_commits, "Commits" },
      b = { telescope_builtin.git_branches, "Branches" },
      s = { telescope_builtin.git_status, "Status" },
      w = {
        name = "+worktree",
        w = { require("telescope").extensions.git_worktree.git_worktrees, "Worktrees" },
        c = { require("telescope").extensions.git_worktree.create_git_worktree, "Create worktree" },
      },
      n = { require("neogit").open, "Neogit" },
    },
    h = {
      name = "+help",
      t = { telescope_builtin.builtin, "Telescope" },
      c = { telescope_builtin.commands, "Commands" },
      h = { telescope_builtin.help_tags, "Help Pages" },
      m = { telescope_builtin.man_pages, "Man Pages" },
      k = { telescope_builtin.keymaps, "Key Maps" },
      s = { telescope_builtin.highlights, "Search Highlight Groups" },
      l = { vim.show_pos, "Highlight Groups at curser" },
      f = { telescope_builtin.filetypes, "File Types" },
      o = { telescope_builtin.vim_options, "Options" },
      a = { telescope_builtin.autocommands, "Auto Commands" },
    },
    s = {
      name = "+search",
      g = { telescope_builtin.live_grep, "Grep" },
      b = { telescope_builtin.current_buffer_fuzzy_find, "Buffer" },
      h = { telescope_builtin.command_history, "Command History" },
      m = { telescope_builtin.marks, "Jump to Mark" },
      w = {
        function()
          telescope_builtin.grep_string({ search = vim.fn.expand("<cword>") })
        end,
        "Current Word",
      },
    },
    f = {
      name = "+file",
      f = { telescope_builtin.find_files, "Find File" },
      r = { telescope_builtin.oldfiles, "Open Recent File" },
    },
    t = {
      name = "+toggle",
      f = {
        require("plugins.lsp.formatting").toggle_formatting,
        "Format on Save",
      },
      s = {
        function()
          util.toggle("spell")
        end,
        "Spelling",
      },
      w = {
        function()
          util.toggle("wrap")
        end,
        "Word Wrap",
      },
      n = {
        function()
          util.toggle("relativenumber")
          util.toggle("number")
        end,
        "Line Numbers",
      },
    },
    [","] = {
      function()
        telescope_builtin.buffers({ show_all_buffers = true })
      end,
      "Switch buffer",
    },
    ["/"] = { telescope_builtin.live_grep, "Search" },
    [":"] = { telescope_builtin.command_history, "Command History" },
    x = {
      name = "+errors",
      l = { vim.cmd.lopen, "Open Location List" },
      q = { vim.cmd.copen, "Open Quickfix List" },
    },
    k = { vim.cmd.lnext, "" },
    j = { vim.cmd.lprev, "" },
    d = {
      b = { require("dap").toggle_breakpoint, "Toggle breakpoint" },
      c = { require("dap").continue, "Continue" },
      o = { require("dap").step_over, "Step over" },
      i = { require("dap").step_into, "Step into" },
      w = { require("dap.ui.widgets").hover, "Widgets" },
      r = { require("dap").repl.open, "Repl" },
      u = {
        function()
          require("dapui").toggle({})
        end,
        "Dap UI",
      },
    },
    o = {
      name = "+open",
    },
    u = { require("telescope").extensions.undo.undo, "Undo history" },
    zz = { require("zen-mode").toggle, "Zen Mode" },
    b = {
      d = {
        function()
          require("mini.bufremove").delete(0, false)
        end,
        "Delete buffer",
      },
      D = {
        function()
          require("mini.bufremove").delete(0, true)
        end,
        "Delete buffer",
      },
    },
  },
}

for i = 0, 10 do
  keymaps[tostring(i)] = "which_key_ignore"
end

wk.register(keymaps)
wk.register({ g = { name = "+goto" } })
