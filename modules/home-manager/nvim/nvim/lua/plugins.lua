local packer = require("util.packer")

local config = {
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
  profile = {
    enable = true,
    threshold = 0,
  },
}

local function plugins(use)
  require("plugins.packer").use(use)
  require("plugins.filetype").use(use)
  require("plugins.lspconfig").use(use)
  require("plugins.null-ls").use(use)
  require("plugins.lua-dev").use(use)
  require("plugins.jdtls").use(use)
  require("plugins.project").use(use)
  require("plugins.luasnip").use(use)
  require("plugins.autopairs").use(use)
  require("plugins.cmp").use(use)
  require("plugins.nvim-code-action-menu").use(use)
  require("plugins.nvim-bqf").use(use)
  require("plugins.comment").use(use)
  require("plugins.treesitter").use(use)
  require("plugins.tokyonight").use(use)
  require("plugins.nvim-web-devicons").use(use)
  require("plugins.nvim-terminal").use(use)
  require("plugins.plenary").use(use)
  require("plugins.popup").use(use)
  require("plugins.telescope").use(use)

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    wants = "tokyonight.nvim",
    config = function()
      require("config.blankline")
    end,
  })

  -- Tabs
  use({
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require("config.bufferline")
    end,
  })

  -- Terminal
  use({
    "akinsho/nvim-toggleterm.lua",
    keys = "<M-`>",
    config = function()
      require("config.terminal")
    end,
  })

  -- Git gutter
  use({
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    wants = "plenary.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("config.gitsigns")
    end,
  })

  use({
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = function()
      require("config.neogit")
    end,
  })

  use({
    "windwp/windline.nvim",
    event = "VimEnter",
    config = function()
      require("config.windline")
    end,
  })

  use({
    "npxbr/glow.nvim",
    cmd = "Glow",
  })

  use({
    "plasticboy/vim-markdown",
    opt = true,
    requires = "godlygeek/tabular",
    ft = "markdown",
  })

  use({
    "ggandor/lightspeed.nvim",
    event = "BufReadPost",
    config = function()
      require("config.lightspeed")
    end,
  })

  use({
    "folke/trouble.nvim",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup({ auto_open = false })
    end,
  })

  use({
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  })

  use({
    "mbbill/undotree",
    cmd = "UndotreeToggle",
  })

  use({
    "kevinhwang91/nvim-hlslens",
  })

  use({
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opt = true,
    wants = "twilight.nvim",
    requires = { "folke/twilight.nvim" },
    config = function()
      require("zen-mode").setup({
        plugins = { gitsigns = true, tmux = true, kitty = { enabled = false, font = "+2" } },
      })
    end,
  })

  use({
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = function()
      require("config.todo")
    end,
  })

  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.keys")
    end,
  })

  use({
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = function()
      require("config.diffview")
    end,
  })

  use({
    "samoshkin/vim-mergetool",
    cmd = "MergetoolStart",
    config = function()
      require("config.mergetool")
    end,
  })

  use({
    "RRethy/vim-illuminate",
    event = "CursorHold",
    module = "illuminate",
    config = function()
      vim.g.illuminate_delay = 1000
    end,
  })

  use({
    "andymass/vim-matchup",
    event = "CursorMoved",
  })
end

return packer.setup(config, plugins)
