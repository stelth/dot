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

local plugins = function(use)
  require("plugins.packer").use(use)
  require("plugins.filetype").use(use)
  require("plugins.lspconfig").use(use)
  require("plugins.jdtls").use(use)
  require("plugins.project").use(use)
  require("plugins.calltree").use(use)
  require("plugins.luasnip").use(use)
  require("plugins.autopairs").use(use)
  require("plugins.renamer").use(use)
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
  require("plugins.nvim-toggleterm").use(use)
  require("plugins.gitsigns").use(use)
  require("plugins.neogit").use(use)
  require("plugins.lualine").use(use)
  require("plugins.glow").use(use)
  require("plugins.vim-markdown").use(use)
  require("plugins.lightspeed").use(use)
  require("plugins.trouble").use(use)
  require("plugins.persistence").use(use)
  require("plugins.undotree").use(use)
  require("plugins.nvim-hlslens").use(use)
  require("plugins.zen-mode").use(use)
  require("plugins.todo-comments").use(use)
  require("plugins.diffview").use(use)
  require("plugins.vim-mergetool").use(use)
  require("plugins.vim-illuminate").use(use)
  require("plugins.vim-matchup").use(use)
  require("plugins.which-key").use(use)
end

packer.setup(config, plugins)