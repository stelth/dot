require("rose-pine").setup({
  disable_italics = true,
  highlight_groups = {
    MiniStatuslineModeNormal = { bg = "rose", fg = "base", gui = "bold" },
    MiniStatuslineModeInsert = { bg = "overlay", fg = "rose", gui = "bold" },
    MiniStatuslineModeVisual = { bg = "iris", fg = "base", gui = "bold" },
    MiniStatuslineModeReplace = { bg = "pine", fg = "base", gui = "bold" },
    MiniStatuslineModeCommand = { bg = "love", fg = "base", gui = "bold" },
    MiniStatuslineInactive = { bg = "base", fg = "muted", gui = "bold" },
  },
})
vim.cmd.colorscheme("rose-pine")

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
