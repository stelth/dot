local completion = {}
local conf = require('modules.completion.config')

completion['kabouzeid/nvim-lspinstall'] = {
    event = 'BufReadPre',
    config = conf.nvim_lspinstall,
    requires = { 'neovim/nvim-lspconfig', 'ray-x/lsp_signature.nvim' }
}

completion['glepnir/lspsaga.nvim'] = {
    cmd = 'Lspsaga'
}

completion['folke/trouble.nvim'] = {
    event = 'BufReadPre',
    config = conf.nvim_trouble,
    requires = 'kyazdani42/nvim-web-devicons'
}

completion['hrsh7th/nvim-compe'] = {
  event = 'BufReadPre',
  config = conf.nvim_compe
}

completion['hrsh7th/vim-vsnip'] = {
    event = 'InsertCharPre',
    requires = { 'rafamadriz/friendly-snippets', 'hrsh7th/vim-vsnip-integ' }
}

completion['nvim-telescope/telescope.nvim'] =
{
    config = conf.telescope,
    requires = {
        {'nvim-lua/popup.nvim', opt = true},
        {'nvim-lua/plenary.nvim', opt = true},
        {'nvim-telescope/telescope-fzy-native.nvim', opt = true},
        {'jvgrootveld/telescope-zoxide', opt = true}
    }
}

return completion
