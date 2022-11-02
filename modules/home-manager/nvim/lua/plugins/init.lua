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
local colors = require("tokyonight.colors").setup()

require("Comment").setup({
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

local augend = require("dial.augend")

require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.bool,
    augend.semver.alias.semver,
  },
})

require("diffview").setup({})

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

require("hlargs").setup({
  color = require("tokyonight.colors").setup().yellow,
  excluded_argnames = {
    usages = {
      lua = { "self", "use" },
    },
  },
})

require("inc_rename").setup()

require("incline").setup({
  highlight = {
    groups = {
      InclineNormal = {
        guibg = "#FC56B1",
        guifg = colors.black,
        -- gui = "bold",
      },
      InclineNormalNC = {
        guifg = "#FC56B1",
        guibg = colors.black,
      },
    },
  },
  window = {
    margin = {
      vertical = 0,
      horizontal = 1,
    },
  },
  render = function(props)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
    local icon, color = require("nvim-web-devicons").get_icon_color(filename)
    return {
      { icon, guifg = color },
      { " " },
      { filename },
    }
  end,
})

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

require("nvim-navic").setup({
  separator = " ",
  highlight = true,
  depth_limit = 5,
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

require("noice").setup({
  presets = {
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
  ts_config = {
    lua = { "string", "comment" },
  },
})

require("notify").setup({
  level = vim.log.levels.INFO,
  fps = 20,
  max_height = function()
    return math.floor(vim.o.lines * 0.75)
  end,
  max_width = function()
    return math.floor(vim.o.columns * 0.75)
  end,
})

require("nvim-surround").setup({})

local parser_dir = vim.fn.expand("~/.local/treesitter")

vim.opt.runtimepath:append(parser_dir)

require("nvim-treesitter.configs").setup({
  parser_install_dir = parser_dir,
  ensure_installed = "all",
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  indent = { enable = true },
})

require("illuminate").configure({ delay = 200 })

vim.g.matchup_matchparen_offscreen = {
  method = "status_manual",
}

require("yanky").setup({
  highlight = {
    timer = 150,
  },
  ring = {
    storage = "sqlite",
  },
})
require("telescope").load_extension("yank_history")

require("todo-comments").setup({
  keywords = {
    TODO = {
      alt = { "WIP" },
    },
  },
})

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

require("trouble").setup({
  auto_open = false,
  use_diagnostic_signs = true,
})

vim.o.winwidth = 5
vim.o.winminwidth = 5
vim.o.equalalways = false
require("windows").setup({
  animation = {
    duration = 150,
  },
})

require("zen-mode").setup({
  plugins = {
    kitty = {
      enabled = false,
      font = "+2",
    },
  },
})

require("plugins.lualine")
require("plugins.nvim-cmp")
require("plugins.nvim-dap")
require("plugins.telescope-nvim")
