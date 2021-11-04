local M = {}

local do_keymaps = function()
  local map = {
    ["`"] = { "<cmd>e #<CR>", "Other Buffer" },
    b = {
      b = { "<cmd>e #<CR>", "Other Buffer" },
      p = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
      ["["] = { "<cmd>BufferLineCyclePrev<CR>", "Previous Buffer" },
      n = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
      ["]"] = { "<cmd>BufferLineCycleNext<CR>", "Next Buffer" },
      d = { "<cmd>bd<CR>", "Delete Buffer" },
      g = { "<cmd>BufferLinePick<CR>", "Pick Buffer" },
    },
  }

  require("which-key").register(map, { prefix = "<leader>" })
end

require("au").group("MapBufferLineKeys", function(grp)
  grp.User = {
    "MapKeys",
    do_keymaps,
  }
end)

local setup = function()
  require("bufferline").setup({
    options = {
      show_close_icon = true,
      diagnostics = "nvim_lsp",
      always_show_bufferline = false,
      separator_style = "slant",
      diagnostics_indicator = function(_, _, diagnostics_dict)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. sym .. n
        end
        return s
      end,
    },
  })
end

M.use = function(use)
  use({
    "akinsho/nvim-bufferline.lua",
    event = "VimEnter",
    config = setup,
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  })
end

return M
