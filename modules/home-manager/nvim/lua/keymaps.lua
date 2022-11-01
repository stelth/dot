local wk = require("which-key")
local utils = require("utils")
local telescope_builtin = require("telescope.builtin")
local tasks = require("tasks")
local gitsigns = require("gitsigns")

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
        tasks.cancel()
        require("dapui").close({})
      end,
      "Cancel Debug",
    },
    ["]h"] = {
      function()
        if vim.wo.diff then
          return "]h"
        end
        vim.schedule(function()
          gitsigns.next_hunk()
        end)
        return "<Ignore>"
      end,
      "Next Hunk",
      expr = true,
    },
    ["[h"] = {
      function()
        if vim.wo.diff then
          return "]h"
        end
        vim.schedule(function()
          gitsigns.prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Prev Hunk",
      expr = true,
    },
    ["ih"] = {
      {
        function()
          vim.cmd.Gitsigns({ "select_hunk" })
        end,
        "Gitsigns Select Hunk",
        mode = "o",
      },
      {
        function()
          vim.cmd.Gitsigns({ "select_hunk" })
        end,
        "Gitsigns Select Hunk",
        mode = "x",
      },
    },
    ["gh"] = { vim.cmd.HopWord, "Hop Word" },
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
      d = { vim.cmd.DiffviewOpen, "DiffView" },
      h = {
        name = "+hunk",
        s = {
          {
            function()
              vim.cmd.Gitsigns({ "stage_hunk" })
            end,
            "Stage Hunk",
          },
          {
            function()
              vim.cmd.Gitsigns({ "stage_hunk" })
            end,
            "Stage Hunk",
            mode = "v",
          },
        },
        r = {
          {
            function()
              vim.cmd.Gitsigns({ "reset_hunk" })
            end,
            "Reset Hunk",
          },
          {
            function()
              vim.cmd.Gitsigns({ "reset_hunk" })
            end,
            "Reset Hunk",
            mode = "v",
          },
        },
        S = { gitsigns.stage_buffer, "Stage Buffer" },
        u = { gitsigns.undo_stage_hunk, "Undo Stage Hunk" },
        R = { gitsigns.reset_buffer, "Reset Buffer" },
        p = { gitsigns.preview_hunk, "Preview Hunk" },
        b = {
          function()
            gitsigns.blame_line({ full = true })
          end,
          "Blame Line",
        },
        d = { gitsigns.diffthis, "Diff This" },
        D = {
          function()
            gitsigns.diffthis("~")
          end,
          "Diff This ~",
        },
      },
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
    r = {
      name = "+run",
      r = {
        name = "+run",
        r = {
          function()
            tasks.start("auto", "run")
          end,
          "Run 'run' Task",
        },
        a = {
          function()
            tasks.set_task_param("auto", "run", "args")
          end,
          "Set 'run' Args",
        },
        e = {
          function()
            tasks.set_task_param("auto", "run", "env")
          end,
          "Set 'run' Environment",
        },
      },
      t = {
        name = "+test",
        r = {
          function()
            tasks.start("auto", "test")
          end,
          "Run 'test' Task",
        },
        a = {
          function()
            tasks.set_task_param("auto", "test", "args")
          end,
          "Set 'test' Args",
        },
        e = {
          function()
            tasks.set_task_param("auto", "test", "env")
          end,
          "Set 'test' Environment",
        },
      },
      b = {
        name = "+build",
        r = {
          function()
            tasks.start("auto", "build")
          end,
          "Run 'build' Task",
        },
        a = {
          function()
            tasks.set_task_param("auto", "build", "args")
          end,
          "Set 'build' Args",
        },
        e = {
          function()
            tasks.set_task_param("auto", "build", "env")
          end,
          "Set 'build' Environment",
        },
      },
      dd = {
        function()
          tasks.start("auto", "debug")
        end,
        "Run 'debug' Task",
      },
      dt = {
        function()
          tasks.start("auto", "debug_test")
        end,
        "Run 'debug_test' Task",
      },
      n = {
        function()
          tasks.start("auto", "clean")
        end,
        "Run Clean Task",
      },
      c = {
        name = "+cmake",
        c = {
          function()
            tasks.start("auto", "configure")
          end,
          "Run CMake Configure Task",
        },
        t = {
          function()
            tasks.set_module_param("auto", "target")
          end,
          "Select CMake Target",
        },
        b = {
          function()
            tasks.set_module_param("auto", "build")
          end,
          "Select CMake Build Type",
        },
      },
      C = {
        name = "+cargo",
        c = {
          function()
            tasks.start("auto", "check")
          end,
          "Run Cargo Check Task",
        },
        l = {
          function()
            tasks.start("auto", "clippy")
          end,
          "Run Cargo clippy Task",
        },
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
      x = {
        function()
          vim.cmd.TroubleToggle({ "workspace_diagnostics" })
        end,
        "Trouble",
      },
      t = { vim.cmd.TodoTrouble, "Todo Trouble" },
      tt = {
        function()
          vim.cmd.TodoTrouble({ "keywords=TODO,FIX,FIXME" })
        end,
        "Todo Trouble",
      },
      T = { vim.cmd.TodoTelescope, "Todo Telescope" },
      l = { vim.cmd.lopen, "Open Location List" },
      q = { vim.cmd.copen, "Open Quickfix List" },
    },
    z = { vim.cmd.ZenMode, "Zen Mode" },
    Z = { vim.cmd.WindowsMaximize, "Maximize Window" },
    k = { vim.cmd.lnext, "" },
    j = { vim.cmd.lprev, "" },
    P = {
      function()
        require("telescope").extensions.yank_history.yank_history({})
      end,
      "Yank History",
    },
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
      g = { vim.cmd.Glow, "Glow" },
    },
  },
}

for i = 0, 10 do
  keymaps[tostring(i)] = "which_key_ignore"
end

wk.register(keymaps)
wk.register({ g = { name = "+goto" } })
