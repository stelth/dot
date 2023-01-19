require("rose-pine").setup({})
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

vim.g.matchup_matchparen_offscreen = {
  method = "status_manual",
}

require("zen-mode").setup({
  window = {
    width = 90,
    options = {
      number = true,
      relativenumber = true,
    },
  },
  plugins = {
    kitty = {
      enabled = false,
      font = "+2",
    },
  },
})

require("plugins.mini")
require("plugins.nvim-cmp")
require("plugins.telescope-nvim")
