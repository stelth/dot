local completion = {}
local conf = require('modules.completion.config')

completion['neovim/nvim-lspconfig'] = {
    event = 'BufReadPre',
    config = conf.nvim_lsp
}

completion['nvim-lua/completion-nvim'] = {
  event = 'BufReadPre',
  config = conf.completion_nvim
}

completion['norcalli/snippets.nvim'] = {
  event = 'BufReadPre',
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
