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
  local_plugins = {},
}

local function plugins(use)
  -- Packer can manage itself as an optional plugin
  use({ "wbthomason/packer.nvim", opt = true })

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    opt = true,
    event = "BufReadPre",
    after = "cmp-nvim-lsp",
    wants = { "null-ls.nvim", "lua-dev.nvim" },
    config = function()
      require("config.lsp")
    end,
    requires = {
      "jose-elias-alvarez/null-ls.nvim",
      "folke/lua-dev.nvim",
    },
  })

  use({
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function()
      require("config.lsp.jdtls")
    end,
  })

  use({
    "ahmedkhalf/project.nvim",
    event = "BufReadPre",
    config = function()
      require("project_nvim").setup({})
    end,
  })

  use({
    "hrsh7th/nvim-cmp",
    module = "cmp",
    config = function()
      require("config.cmp")
    end,
    wants = "LuaSnip",
    requires = {
      {
        "L3MON4D3/LuaSnip",
        event = "BufReadPre",
        wants = "friendly-snippets",
        config = function()
          require("config.snippets")
        end,
      },
      "rafamadriz/friendly-snippets",
      {
        "windwp/nvim-autopairs",
        event = "BufReadPre",
        after = "nvim-cmp",
        config = function()
          require("config.autopairs")
        end,
      },
      { "onsails/lspkind-nvim", module = "lspkind" },
      { "hrsh7th/cmp-buffer", module = "cmp_buffer" },
      { "hrsh7th/cmp-path", module = "cmp_path" },
      { "saadparwaiz1/cmp_luasnip", module = "cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" },
      { "hrsh7th/cmp-calc", module = "cmp_calc" },
      { "kdheepak/cmp-latex-symbols", module = "cmp_latex_symbols" },
      { "hrsh7th/cmp-emoji", module = "cmp_emoji" },
    },
  })

  use({
    "b3nj5m1n/kommentary",
    opt = true,
    wants = "nvim-ts-context-commentstring",
    keys = { "gc", "gcc" },
    config = function()
      require("config.comments")
    end,
    requires = "JoosepAlviste/nvim-ts-context-commentstring",
  })

  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    opt = true,
    event = "BufRead",
    module = "nvim-treesitter.fold",
    requires = {
      { "nvim-treesitter/playground", cmd = "TSHighlightCapturesUnderCursor" },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "RRethy/nvim-treesitter-textsubjects",
    },
    config = function()
      require("config.treesitter")
    end,
  })

  -- Theme: Color schemes
  use({
    "folke/tokyonight.nvim",
    config = function()
      require("config.theme")
    end,
  })

  -- Theme: icons
  use({
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({ default = true })
    end,
  })

  use({
    "norcalli/nvim-terminal.lua",
    ft = "terminal",
    config = function()
      require("terminal").setup()
    end,
  })

  use({
    "nvim-lua/plenary.nvim",
    module = "plenary",
  })

  use({
    "nvim-lua/popup.nvim",
    module = "popup",
  })

  use({
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeClose" },
    config = function()
      require("config.tree")
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    opt = true,
    config = function()
      require("config.telescope")
    end,
    cmd = { "Telescope" },
    module = "telescope",
    keys = { "<leader><space>", "<leader>fz", "<leader>pp", "<leader>fd" },
    wants = {
      "plenary.nvim",
      "popup.nvim",
      "telescope-z.nvim",
      "telescope-fzy-native.nvim",
      "telescope-project.nvim",
      "trouble.nvim",
      "telescope-symbols.nvim",
      "telescope-zoxide",
      "neovim-cmake",
    },
    requires = {
      "nvim-telescope/telescope-z.nvim",
      "nvim-telescope/telescope-project.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "jvgrootveld/telescope-zoxide",
      {
        "Shatur/neovim-cmake",
        wants = { "asyncrun.vim" },
        cmd = { "CMake" },
        requires = {
          "skywind3000/asyncrun.vim",
        },
        config = function()
          require("config.cmake")
        end,
      },
    },
  })

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

  -- Status line
  use({
    "hoob3rt/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config.lualine")
    end,
    wants = "nvim-web-devicons",
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
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime",
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
