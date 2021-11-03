local M = {}

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

  local util = require("util")
  util.nnoremap("<leader>`", ":e #<CR>")
  util.nnoremap("<leader>bb", ":e #<CR>")
  util.nnoremap("<leader>bp", ":BufferLineCyclePrev<CR>")
  util.nnoremap("<leader>b[", ":BufferLineCyclePrev<CR>")
  util.nnoremap("<leader>bn", ":BufferLineCycleNext<CR>")
  util.nnoremap("<leader>b]", ":BufferLineCycleNext<CR>")
  util.nnoremap("<leader>bd", ":bd<CR>")
  util.nnoremap("<leader>bg", ":BufferLinePick<CR>")
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
