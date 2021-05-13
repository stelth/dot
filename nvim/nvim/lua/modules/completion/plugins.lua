local completion = {}
local conf = require('modules.completion.config')

completion['kabouzeid/nvim-lspinstall'] = {
    event = 'BufReadPre',
    config = conf.nvim_lspinstall,
    requires = { 'neovim/nvim-lspconfig' }
}

completion['glepnir/lspsaga.nvim'] = {
    cmd = 'Lspsaga'
}

completion['folke/trouble.nvim'] = {
    cmd = { 'LspTrouble', 'LspTroubleToggle', 'LspTroubleWorkspaceToggle', 'LspTroubleDocumentToggle' },
    config = conf.nvim_trouble,
    requires = 'kyazdani42/nvim-web-devicons'
}

completion['nvim-lua/completion-nvim'] = {
  event = 'BufReadPre',
  config = conf.completion_nvim
}

completion['hrsh7th/vim-vsnip'] = {
  event = 'BufReadPre',
  requires = { 'rafamadriz/friendly-snippets', 'hrsh7th/vim-vsnip-integ' }
}

completion['nvim-telescope/telescope.nvim'] =
{
    cmd = 'Telescope',
    config = conf.telescope,
    requires = {
        {'nvim-lua/popup.nvim', opt = true},
        {'nvim-lua/plenary.nvim', opt = true},
        {'nvim-telescope/telescope-fzy-native.nvim', opt = true}
    }
}

return completion
