local M = {}

local do_keymaps = function()
  local map = {
    n = { "<cmd>execute('normal!' . v:count1 . 'n')<CR><cmd>lua require('hlslens').start()<CR>" },
    N = { "<cmd>execute('normal!' , v:count1 . 'N')<CR><cmd>lua requrei('hlslens').start()<CR>" },
    ["*"] = { "*<cmd>lua require('hlslens').start()<CR>" },
    ["#"] = { "#<cmd>lua require('hlslens').start()<CR>" },
    ["g*"] = { "g*<cmd>lua require('hlslens').start()<CR>" },
    ["g#"] = { "g#<cmd>lua require('hlslens').start()<CR>" },
    ["<BS>"] = { ":noh<CR>" },
  }

  require("which-key").register(map)
end

require("au").group("HlslensKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function() end

M.use = function(use)
  use({
    "kevinhwang91/nvim-hlslens",
    event = "VimEnter",
    config = setup,
  })
end

return M
