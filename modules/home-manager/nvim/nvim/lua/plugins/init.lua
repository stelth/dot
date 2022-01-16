local packer = require("util.packer")

local config = {
  max_jobs = 4,
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "single" })
    end,
  },
  compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
  profile = {
    enable = true,
    threshold = 0,
  },
}

local plugins = function(use)
  require("plugins.autopairs").use(use)
  require("plugins.close-buffers").use(use)
  require("plugins.cmake").use(use)
  require("plugins.cmp").use(use)
  require("plugins.comment").use(use)
  require("plugins.dap").use(use)
  require("plugins.diffview").use(use)
  require("plugins.dressing").use(use)
  require("plugins.filetype").use(use)
  require("plugins.gitsigns").use(use)
  require("plugins.glow").use(use)
  require("plugins.impatient").use(use)
  require("plugins.indent-blankline").use(use)
  require("plugins.jdtls").use(use)
  require("plugins.lightspeed").use(use)
  require("plugins.lspconfig").use(use)
  require("plugins.lualine").use(use)
  require("plugins.luasnip").use(use)
  require("plugins.notify").use(use)
  require("plugins.nvim-bqf").use(use)
  require("plugins.nvim-bufferline").use(use)
  require("plugins.nvim-gps").use(use)
  require("plugins.nvim-hlslens").use(use)
  require("plugins.nvim-terminal").use(use)
  require("plugins.nvim-toggleterm").use(use)
  require("plugins.nvim-web-devicons").use(use)
  require("plugins.onedark").use(use)
  require("plugins.packer").use(use)
  require("plugins.plenary").use(use)
  require("plugins.popup").use(use)
  require("plugins.telescope").use(use)
  require("plugins.treesitter").use(use)
  require("plugins.undotree").use(use)
  require("plugins.vim-illuminate").use(use)
  require("plugins.vim-markdown").use(use)
  require("plugins.vim-matchup").use(use)
  require("plugins.vim-mergetool").use(use)
end

packer.setup(config, plugins)
