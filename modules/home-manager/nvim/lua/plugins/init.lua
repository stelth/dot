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

require("hop").setup()

require("inc_rename").setup()

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

require("mini.jump").setup({})

require("nvim-navic").setup({
  icons = {
    File = " ",
    Module = " ",
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = " ",
    Property = " ",
    Field = " ",
    Constructor = " ",
    Enum = " ",
    Interface = " ",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = " ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = " ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  separator = " ",
  highlight = true,
  depth_limit = 5,
})

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

require("luasnip").config.set_config({
  history = true,
  -- Update more often
  updateEvents = "TextChanged,TextChangedI",
})

require("luasnip/loaders/from_vscode").lazy_load()

require("tasks").setup({
  dap_open_command = require("dapui").open,
})

require("noice").setup({
  cmdline = {
    format = {
      IncRename = {
        pattern = "^:%s*IncRename%s+",
        icon = " ",
        conceal = true,
        opts = {
          relative = "cursor",
          size = { min_width = 20 },
          position = { row = -3, col = 0 },
          buf_options = { filetype = "text" },
        },
      },
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
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

require("nvim-treesitter.configs").setup({
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

require("trouble").setup({
  auto_open = false,
  use_diagnostic_signs = true,
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
