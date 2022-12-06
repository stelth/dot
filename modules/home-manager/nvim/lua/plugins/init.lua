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
    leap = true,
    mini = true,
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
    treesitter_context = true,
    which_key = true,
  },
})
vim.cmd.colorscheme("catppuccin")

require("leap").add_default_mappings()
require("flit").setup({
  labeled_modes = "nv",
})
vim.keymap.set({ "n", "x", "o" }, "M", function()
  require("leap-ast").leap()
end)

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
        event = "msg_show",
        find = "%d+L, %d+B",
      },
      view = "mini",
    },
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
  commands = {
    all = {
      view = "split",
      opts = { enter = true, format = "details" },
      filter = {},
    },
  },
})

require("notify").setup({
  timeout = 3000,
  level = vim.log.levels.INFO,
  fps = 20,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
})

require("nvim-treesitter.configs").setup({
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = {
    select = {
      enable = false,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = false,
      set_jumps = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
    lsp_interop = {
      enable = false,
      peek_definition_code = {
        ["gD"] = "@function.outer",
      },
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ["."] = "textsubjects-smart",
      [";"] = "textsubjects-container-outer",
    },
  },
  indent = { enable = true },
})

require("treesitter-context").setup({})

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
require("plugins.mini")
require("plugins.neovim-tasks")
require("plugins.nvim-cmp")
require("plugins.nvim-dap")
require("plugins.telescope-nvim")
