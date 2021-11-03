local M = {}

local setup = function()
  local wk = require("which-key")
  vim.opt.timeoutlen = 100

  local presets = require("which-key.plugins.presets")
  presets.objects["a("] = nil
  wk.setup({
    show_help = false,
    triggers = "auto",
    plugins = { spelling = true, presets = { operators = true, text_objects = true } },
    key_labels = { ["<leader>"] = "SPC" },
  })

  local util = require("util")

  local leader = {
    b = {
      name = "+buffer",
    },
    g = {
      name = "+git",
      g = { "<cmd>Neogit<CR>", "NeoGit" },
      l = {
        function()
          require("util").float_terminal("lazygit")
        end,
        "LazyGit",
      },
      c = { "<Cmd>Telescope git_commits<CR>", "commits" },
      b = { "<Cmd>Telescope git_branches<CR>", "branches" },
      s = { "<Cmd>Telescope git_status<CR>", "status" },
      d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
      h = { name = "+hunk" },
    },
    ["h"] = {
      name = "+help",
      t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
      c = { "<cmd>:Telescope commands<cr>", "Commands" },
      h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
      m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
      k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
      s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
      l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
      f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
      o = { "<cmd>:Telescope vim_options<cr>", "Options" },
      a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
      p = {
        name = "+packer",
        p = { "<cmd>PackerSync<cr>", "Sync" },
        s = { "<cmd>PackerStatus<cr>", "Status" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        c = { "<cmd>PackerCompile<cr>", "Compile" },
      },
    },
    u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
    s = {
      name = "+search",
      g = { "<cmd>Telescope live_grep<cr>", "Grep" },
      b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
      s = {
        function()
          require("telescope.builtin").lsp_document_symbols({
            symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module" },
          })
        end,
        "Goto Symbol",
      },
      h = { "<cmd>Telescope command_history<cr>", "Command History" },
      m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
    },
    f = {
      name = "+file",
      t = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      n = { "<cmd>enew<cr>", "New File" },
      z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
    },
    o = {
      name = "+open",
      g = { "<cmd>Glow<cr>", "Markdown Glow" },
    },
    t = {
      name = "toggle",
      f = {
        require("lsp.formatting").toggle,
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
          util.toggle("relativenumber", true)
          util.toggle("number")
        end,
        "Line Numbers",
      },
    },
    ["<tab>"] = {
      name = "workspace",
      ["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

      n = { "<cmd>tabnext<CR>", "Next" },
      d = { "<cmd>tabclose<CR>", "Close" },
      p = { "<cmd>tabprevious<CR>", "Previous" },
      ["]"] = { "<cmd>tabnext<CR>", "Next" },
      ["["] = { "<cmd>tabprevious<CR>", "Previous" },
      f = { "<cmd>tabfirst<CR>", "First" },
      l = { "<cmd>tablast<CR>", "Last" },
    },
    ["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
    ["."] = { ":Telescope file_browser<CR>", "Browse Files" },
    [","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
    ["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
    [":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
    q = {
      name = "+quit/session",
      q = { "<cmd>:qa<cr>", "Quit" },
      ["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
      s = { "<cmd>lua require('persistence').load()<cr>", "Restore Session" },
      l = { "<cmd>lua require('persistence').load({last = true})<CR>", "Restore Last Session" },
      d = { "<cmd>lua require('persistence').stop()<CR>", "Stop Current Session" },
    },
    x = {
      name = "+errors",
      x = { "<cmd>TroubleToggle<cr>", "Trouble" },
      w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "Workspace Trouble" },
      d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "Document Trouble" },
      t = { "<cmd>TodoTrouble<CR>", "Todo Trouble" },
      T = { "<cmd>TodoTelescope<CR>", "Todo Telescope" },
      l = { "<cmd>lopen<cr>", "Open Location List" },
      q = { "<cmd>copen<cr>", "Open Quickfix List" },
    },
    Z = { [[<cmd>lua require("zen-mode").reset()<cr>]], "Zen Mode" },
    z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
    T = { [[<Plug>PlenaryTestFile]], "Plenary Test" },
  }

  for i = 0, 10 do
    leader[tostring(i)] = "which_key_ignore"
  end

  wk.register(leader, { prefix = "<leader>" })
end

function M.use(use)
  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = setup,
  })
end

return M
