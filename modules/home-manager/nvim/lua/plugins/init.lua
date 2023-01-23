local default_colors = require("kanagawa.colors").setup()
require("kanagawa").setup({
  overrides = {
    MiniStatuslineDevinfo = { fg = default_colors.fg_dark, bg = default_colors.bg_light0 },
    MiniStatuslineFileinfo = { fg = default_colors.fg_dark, bg = default_colors.bg_light0 },
    MiniStatuslineFilename = { fg = default_colors.fg_dark, bg = default_colors.bg_status },
    MiniStatuslineInactive = { fg = default_colors.fg_comment, bg = default_colors.bg_status },
    MiniStatuslineModeCommand = { fg = default_colors.bg_dark, bg = default_colors.op, bold = true },
    MiniStatuslineModeInsert = { fg = default_colors.bg_dark, bg = default_colors.git.added, bold = true },
    MiniStatuslineModeNormal = { fg = default_colors.bg_dark, bg = default_colors.fn, bold = true },
    MiniStatuslineModeOther = { fg = default_colors.bg_dark, bg = default_colors.dep, bold = true },
    MiniStatuslineModeReplace = { fg = default_colors.bg_dark, bg = default_colors.git.removed, bold = true },
    MiniStatuslineModeVisual = { fg = default_colors.bg_dark, bg = default_colors.kw, bold = true },
  },
})
vim.cmd.colorscheme("kanagawa")

require("git-worktree").setup({})

require("inc_rename").setup()

require("terminal").setup({})

require("luasnip").config.set_config({
  history = true,
  enable_autosnippets = true,
  updateEvents = "TextChanged,TextChangedI",
})
require("luasnip/loaders/from_vscode").lazy_load()

require("mini.move").setup({})

require("mini.pairs").setup({})

require("mini.statusline").setup({})

require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
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
      enable = true,
      set_jumps = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
  },
  indent = { enable = true },
})

vim.g.matchup_matchparen_offscreen = {
  method = "status_manual",
}

require("plugins.nvim-cmp")
require("plugins.telescope-nvim")
