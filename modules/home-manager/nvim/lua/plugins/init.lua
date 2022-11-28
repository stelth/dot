require("catppuccin").setup({
  integrations = {
    cmp = true,
    dap = {
      enabled = true,
      enabled_ui = true,
    },
    gitsigns = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
    noice = true,
    notify = true,
    telescope = true,
    treesitter = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")

require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

require("gitsigns").setup({})

require("inc_rename").setup()

require("indent_blankline").setup({})

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

require("noice").setup({
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = true,
    lsp_doc_border = true,
  },
  routes = {
    {
      filter = {
        warning = true,
        find = "offset_encodings",
      },
      opts = {
        skip = true,
      },
    },
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  lsp_progress = {
    enabled = true,
  },
})

require("nvim-autopairs").setup({
  check_ts = true,
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
