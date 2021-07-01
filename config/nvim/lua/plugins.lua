local packer = require("packer")

local global = require("global")

local config = {
  compile_path = global.data_dir .. "/plugin/packer_compiled.vim",
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

local locals = { ["null-ls.nvim"] = "folke" }

local function get_name(pkg)
  local parts = vim.split(pkg, "/")
  return parts[#parts]
end

local function process(spec)
  if type(spec) == "string" then
    local name = get_name(spec)

    if locals[name] then
      return locals[name] .. "/" .. name
    end

    return spec
  else
    for i, s in ipairs(spec) do
      spec[i] = process(s)
    end
  end

  if spec.requires then
    spec.requires = process(spec.requires)
  end

  return spec
end

local function wrap(use)
  return function(spec)
    spec = process(spec)
    use(spec)
  end
end

return packer.startup({
  function(use)
    use = wrap(use)
    -- Packer can manage itself as an optional plugin
    use({ "wbthomason/packer.nvim", opt = true })

    -- LSP
    use({
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = { "null-ls.nvim", "lua-dev.nvim" },
      config = function()
        require("config.lsp")
      end,
      requires = {
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        { "jose-elias-alvarez/null-ls.nvim", branch = "lspconfig" },
        "folke/lua-dev.nvim",
      },
    })

    -- DAP
    use({
      "mfussenegger/nvim-dap",
      opt = true,
      event = "BufReadPre",
      wants = { "nvim-dap-python" },
      config = function()
        require("config.dap")
      end,
      requires = {
        "mfussenegger/nvim-dap-python",
        "theHamsta/nvim-dap-virtual-text",
      },
    })

    use({
      "hrsh7th/nvim-compe",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.compe")
      end,
      wants = { "LuaSnip" },
      requires = {
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("config.snippets")
          end,
        },
        "rafamadriz/friendly-snippets",
        {
          "windwp/nvim-autopairs",
          config = function()
            require("config.autopairs")
          end,
        },
      },
    })

    use({
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
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

    -- Dashboard
    use({
      "glepnir/dashboard-nvim",
      config = function()
        require("config.dashboard")
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
      cmd = { "NvimTreeToggle", "NvimTreeOpen" },
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
      keys = { "<leader><space>", "<leader>fz", "<leader>pp" },
      wants = {
        "plenary.nvim",
        "popup.nvim",
        "telescope-z.nvim",
        "telescope-fzy-native.nvim",
        "telescope-project.nvim",
        "trouble.nvim",
        "telescope-symbols.nvim",
        "telescope-dap.nvim",
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
        "nvim-telescope/telescope-dap.nvim",
        "jvgrootveld/telescope-zoxide",
        {
          "Shatur/neovim-cmake",
          wants = { "asyncrun.vim", "nvim-dap" },
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
      branch = "lua",
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

    -- Smooth scrolling
    use({
      "karb94/neoscroll.nvim",
      keys = { "<C-u>", "<C-d>", "gg", "G" },
      config = function()
        require("config.scroll")
      end,
    })

    use({
      "edluffy/specs.nvim",
      after = "neoscroll.nvim",
      config = function()
        require("config.specs")
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
      keys = { "s", "S", "f", "F", "t", "T" },
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
      "mjlbach/babelfish.nvim",
      module = "babelfish",
    })

    use({
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
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
      "aserowy/tmux.nvim",
      config = function()
        require("config.tmux")
      end,
    })

    use({
      "wellle/targets.vim",
    })

    use({
      "DanilaMihailov/vim-tips-wiki",
    })

    use({
      "andymass/vim-matchup",
      event = "CursorMoved",
    })

    use({
      "camspiers/snap",
      module = "snap",
    })
  end,
  config = config,
})
