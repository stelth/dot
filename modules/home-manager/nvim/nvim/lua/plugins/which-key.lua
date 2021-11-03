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
    q = {
      name = "+quit/session",
    },
    x = {
      name = "+errors",
    },
  }

  for i = 0, 10 do
    leader[tostring(i)] = "which_key_ignore"
  end

  wk.register(leader, { prefix = "<leader>" })
end

M.use = function(use)
  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = setup,
  })
end

return M
