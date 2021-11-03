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
  require("plugins.indent-blankline").use(use)
  require("plugins.nvim-bufferline").use(use)
  require("plugins/nvim-toggleterm").use(use)
  require("plugins.gitsigns").use(use)
  require("plugins.neogit").use(use)
  require("plugins.windline").use(use)
  require("plugins.glow").use(use)
  require("plugins/vim-markdown").use(use)
  require("plugins.lightspeed").use(use)
  require("plugins.trouble").use(use)
  require("plugins.persistence").use(use)
  require("plugins.undotree").use(use)
  require("plugins.nvim-hlslens").use(use)
  require("plugins.zen-mode").use(use)
  require("plugins.todo-comments").use(use)
  require("plugins.diffview").use(use)

  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("config.keys")
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
