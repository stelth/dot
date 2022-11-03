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
  on_colors = function(_) end,
  on_highlights = function(hl, c)
    -- make the current line cursor orange
    hl.CursorLineNr = { fg = c.orange, bold = true }

    -- borderless telescope
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = c.fg_gutter,
      fg = c.orange,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
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

require("glow").setup({})

require("indent_blankline").setup({
  viewport_buffer = 100,
  char = "▎",
  filetype_exclude = {
    "vimwiki",
    "man",
    "gitmessengerpopup",
    "diagnosticpopup",
    "lspinfo",
    "checkhealth",
    "TelescopePrompt",
    "TelescopeResults",
    "",
  },
  buftype_exclude = { "terminal" },
  space_char_blankline = " ",
  show_foldtext = false,
  strict_tabs = true,
  debug = true,
  disable_with_nolist = true,
  max_indent_increase = 1,
  show_current_context = true,
  show_current_context_start = true,
  use_treesitter_scope = true,
})

require("inlay-hints").setup({
  renderer = "inlay-hints/render/eol",
})

require("neogen").setup({
  snippet_engine = "luasnip",
})

require("terminal").setup({})

require("luasnip").config.set_config({
  history = true,
  enable_autosnippets = true,
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").lazy_load()

require("tasks").setup({
  dap_open_command = require("dapui").open,
})

require("nvim-autopairs").setup({
  check_ts = true,
  ts_config = {
    lua = { "string", "comment" },
  },
})

require("nvim-surround").setup({})

local parser_dir = vim.fn.expand("~/.local/treesitter")

vim.opt.runtimepath:append(parser_dir)

require("nvim-treesitter.configs").setup({
  parser_install_dir = parser_dir,
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "diff",
    "dockerfile",
    "git_rebase",
    "gitattributes",
    "gitignore",
    "go",
    "java",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nix",
    "python",
    "regex",
    "rust",
    "sql",
    "toml",
    "vim",
    "yaml",
  },
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
