local tokyonight = require("tokyonight")
tokyonight.setup({
  style = "moon",
  -- transparent = true,
  -- hide_inactive_statusline = false,
  sidebars = {
    "qf",
    "vista_kind",
    "terminal",
    "packer",
    "spectre_panel",
    "NeogitStatus",
    "help",
    "startuptime",
    "Outline",
  },
  on_highlights = function(hl, c)
    -- make the current line cursor orange
    hl.CursorLineNr = { fg = c.orange, bold = true }
  end,
})
tokyonight.load()

require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

require("gitsigns").setup({
  signs = {
    add = { hl = "GitSignsAdd", text = "▍", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = {
      hl = "GitSignsChange",
      text = "▍",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
    delete = {
      hl = "GitSignsDelete",
      text = "▸",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      hl = "GitSignsDelete",
      text = "▾",
      numhl = "GitSignsDeleteNr",
      linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      hl = "GitSignsChange",
      text = "▍",
      numhl = "GitSignsChangeNr",
      linehl = "GitSignsChangeLn",
    },
  },
})

require("inlay-hints").setup({
  renderer = "inlay-hints/render/eol",
})

require("terminal").setup({})

require("luasnip").config.set_config({
  history = true,
  enable_autosnippets = true,
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").lazy_load()

require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "comment" },
  },
})

require("nvim-surround").setup({})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true },
})

vim.g.matchup_matchparen_offscreen = {
  method = "status_manual",
}

require("toggleterm").setup({
  size = 20,
  hide_numbers = true,
  open_mapping = [[<C-_>]],
  shade_filetypes = {},
  shade_terminals = false,
  shading_factor = 0.3,
  start_in_insert = true,
  persist_size = true,
  direction = "horizontal",
})
-- Esc twice to get to normal mode
vim.cmd([[tnoremap <esc><esc> <C-\><C-N>]])

require("plugins.lualine")
require("plugins.nvim-cmp")
require("plugins.nvim-dap")
require("plugins.telescope-nvim")
