local wk = require("which-key")
local utils = require("utils")
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
    J = {
      { "mzJ`z", "" },
      { ":m '>+1<CR>gv=gv", "Move Line Down", mode = "v" },
    },
    K = { ":m '<-2<CR>gv=gv", "Move Line Up", mode = "v" },
    ["<C-d>"] = { "<C-d>zz" },
    ["<C-u>"] = { "<C-u>zz" },
    [","] = { ",<c-g>u", "", mode = "i" },
    ["."] = { ".<c-g>u", "", mode = "i" },
    [";"] = { ";<c-g>u", "", mode = "i" },
    ["<"] = { "<gv", "", mode = "v" },
    [">"] = { ">gv", "", mode = "v" },
    n = {
      expr = true,
      { "'Nn'[v:searchforward]", "" },
      { "'Nn'[v:searchforward]", "", mode = "x" },
      { "'Nn'[v:searchforward]", "", mode = "o" },
    },
    N = {
      expr = true,
      { "'nN'[v:searchforward]", "" },
      { "'nN'[v:searchforward]", "", mode = "x" },
      { "'nN'[v:searchforward]", "", mode = "o" },
    },
    ["<C-k>"] = { vim.cmd.cnext, "" },
    ["<C-j>"] = { vim.cmd.cprev, "" },
    ["<BS>"] = { vim.cmd.nohlsearch, "" },
    ["<C-i>"] = { require("dial.map").inc_normal, "" },
    ["<C-x>"] = { require("dial.map").dec_normal, "" },
    ["]]"] = {
      function()
        require("illuminate").goto_next_reference(false)
      end,
      "Go to Next Reference",
    },
    ["[["] = {
      function()
        require("illuminate").goto_prev_reference(false)
      end,
      "Go to Previous Reference",
    },
    y = {
      { "<Plug>(YankyYank)", "Yank" },
      { "<Plug>(YankyYank)", "Yank", mode = "x" },
    },
    p = {
      { "<Plug>(YankyPutAfter)", "Yank Put After" },
      { "<Plug>(YankyPutAfter)", "Yank Put After", mode = "x" },
    },
    P = {
      { "<Plug>(YankyPutBefore)", "Yank Put Before" },
      { "<Plug>(YankyPutBefore)", "Yank Put Before", mode = "x" },
    },
    g = {
      p = {
        { "<Plug>(YankyGPutAfter)", "Yank G Put After" },
        { "<Plug>(YankyGPutAfter)", "Yank G Put After", mode = "x" },
      },
      P = {
        { "<Plug>(YankyGPutBefore)", "Yank G Put Before" },
        { "<Plug>(YankyGPutBefore)", "Yank G Put Before", mode = "x" },
      },
    },
    ["<C-y>"] = { "<Plug>(YankyCycleForward)", "Yank Cycle Forward" },
    ["<C-p>"] = { "<Plug>(YankyCycleBackward)", "Yank Cycle Backwards" },
    ["]p"] = { "<Plug>(YankyPutAfterFilter)", "Yank Put After Filter" },
    ["[p"] = { "<Plug>(YankyPutBeforeFilter)", "Yank Put Before Filter" },
    ["<C-BS>"] = {
      function()
        require("tasks").cancel()
        require("dapui").close()
      end,
      "Cancel Debug",
    },
    ["<F1>"] = {
      function()
        require("tasks").start("auto", "run")
      end,
      "Run 'Run' Task",
    },
    ["<S-F1>"] = {
      function()
        require("tasks").set_task_param("auto", "run", "args")
      end,
      "Set args for 'Run' Task",
    },
    ["<A-F1>"] = {
      function()
        require("tasks").set_task_param("auto", "run", "env")
      end,
      "Set env for 'Run' Task",
    },
    ["<F2>"] = {
      function()
        require("tasks").start("auto", "test")
      end,
      "Run 'test' Task",
    },
    ["<S-F2>"] = {
      function()
        require("tasks").set_task_param("auto", "test", "args")
      end,
      "Set args for 'test' Task",
    },
    ["<A-F2>"] = {
      function()
        require("tasks").set_task_param("auto", "test", "env")
      end,
      "Set env for 'test' Task",
    },
    ["<F3>"] = {
      function()
        require("tasks").start("auto", "build")
      end,
      "Run 'build' Task",
    },
    ["<S-F3>"] = {
      function()
        require("tasks").set_task_param("auto", "build", "args")
      end,
      "Set args for 'build' Task",
    },
    ["<A-F3>"] = {
      function()
        require("tasks").set_task_param("auto", "build", "env")
      end,
      "Set env for 'build' Task",
    },
    ["<F4>"] = {
      function()
        require("tasks").start("auto", "debug")
      end,
      "Run 'debug' Task",
    },
    ["<F5>"] = {
      function()
        require("tasks").start("auto", "debug_test")
      end,
      "Run 'debug_test' Task",
    },
    ["<F6>"] = {
      function()
        require("tasks").start("auto", "configure")
      end,
      "Run CMake configure Task",
    },
    ["<C-F6>"] = {
      function()
        require("tasks").set_module_param("auto", "target")
      end,
      "Select CMake target",
    },
    ["<A-F6>"] = {
      function()
        require("tasks").set_module_param("auto", "build")
      end,
      "Select CMake build type",
    },
    ["<F7>"] = {
      function()
        require("tasks").start("auto", "check")
      end,
      "Run Cargo check task",
    },
    ["<C-F7>"] = {
      function()
        require("tasks").start("auto", "clippy")
      end,
      "Run Cargo clippy task",
    },
    ["<A-F7>"] = {
      function()
        require("tasks").start("auto", "clean")
      end,
      "Run clean task",
    },
    ["<F13>"] = { require("dap").step_over, "Step Over" },
    ["<F14>"] = { require("dap").step_into, "Step Into" },
    ["<F15>"] = { require("dap").step_out, "Step Out" },
    ["<F16>"] = { require("dap").pause, "Pause" },
    ["<F17>"] = { require("dap").continue, "Continue" },
    ["<F18>"] = { require("dapui").toggle, "Toggle UI" },
    ["<F19>"] = { require("dap").toggle_breakpoint, "Toggle Breakpoint" },
    ["<F20>"] = {
      function()
        vim.ui.input({ prompt = "Breakpoint Condition: " }, function(condition)
          require("dap").set_breakpoint(condition)
        end)
      end,
      "Set Conditional Breakpoint",
    },
    ["<F21>"] = {
      function()
        vim.ui.input({ prompt = "Log point message: " }, function(message)
          require("dap").set_breakpoint(nil, nil, message)
        end)
      end,
      "Set log point message",
    },
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
      c = { telescope_builtin.git_commits, "Commits" },
      b = { telescope_builtin.git_branches, "Branches" },
      s = { telescope_builtin.git_status, "Status" },
      d = { vim.cmd.DiffviewOpen, "DiffView" },
    },
    h = {
      name = "+help",
      t = { telescope_builtin.builtin, "Telescope" },
      c = { telescope_builtin.commands, "Commands" },
      h = { telescope_builtin.help_tags, "Help Pages" },
      m = { telescope_builtin.man_pages, "Man Pages" },
      k = { telescope_builtin.keymaps, "Key Maps" },
      s = { telescope_builtin.highlights, "Search Highlight Groups" },
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
    ["."] = { require("telescope").extensions.file_browser.file_browser, "Browse Files" },
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
    z = { vim.cmd.ZenMode, "Zen Mode" },
    k = { vim.cmd.lnext, "" },
    j = { vim.cmd.lprev, "" },
    P = {
      function()
        require("telescope").extensions.yank_history.yank_history({})
      end,
      "Yank History",
    },
  },
}

for i = 0, 10 do
  keymaps[tostring(i)] = "which_key_ignore"
end

wk.register(keymaps)
wk.register({ g = { name = "+goto" } })
