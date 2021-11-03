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
      h = { name = "+hunk" },
    },
    ["h"] = {
      name = "+help",
      p = {
        name = "+packer",
      },
    },
    s = {
      name = "+search",
    },
    f = {
      name = "+file",
    },
    o = {
      name = "+open",
    },
    t = {
      name = "toggle",
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
