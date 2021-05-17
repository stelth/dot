local editor = {}
local conf = require('modules.editor.config')

editor['itchyny/vim-cursorword'] = {
    event = {'BufReadPre', 'BufNewFile'},
    config = conf.vim_cursorword
}

editor['folke/which-key.nvim'] = {
    config = conf.which_key
}

editor['kevinhwang91/nvim-hlslens'] = {
}

editor['mbbill/undotree'] = {
}

editor['folke/zen-mode.nvim'] = {
    event = 'BufReadPre',
}

return editor
