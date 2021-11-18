local M = {}

local setup = function()
  require("calltree").setup({})
end

local do_keymaps = function()
  local map = {
    c = {
      t = {
        name = "Tree",
        i = { "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", "Incoming Calls" },
        o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", "Outgoing Calls" },
        f = { "<cmd>CTFocus<CR>", "Focus" },
        h = { "<cmd>CTHover<CR>", "Hover" },
        j = { "<cmd>CTJump<CR>", "Jump" },
        s = { "<cmd>CTSwitch<CR>", "Switch Directions" },
      },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("au").group("CallTreeKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

M.use = function(use)
  use({
    "ldelossa/calltree.nvim",
    keys = { "<leader>cti", "<leader>cto" },
    config = setup,
  })
end

return M
