local editor = {}
local conf = require('modules.editor.config')

editor['rhysd/accelerated-jk'] = {opt = true}

editor['itchyny/vim-cursorword'] = {
    event = {'BufReadPre', 'BufNewFile'},
    config = conf.vim_cursorword
}

editor['hrsh7th/vim-eft'] = {
    opt = true,
    config = conf.vim_eft
}

editor['kana/vim-operator-replace'] = {
    keys = {{'x', 'p'}},
    config = conf.operator_replace,
    requires = 'kana/vim-operator-user'
}

editor['rhysd/vim-operator-surround'] = {
    event = 'BufRead',
    requires = 'kana/vim-operator-user'
}

editor['folke/which-key.nvim'] = {
    config = conf.which_key
}

editor['kana/vim-niceblock'] = {opt = true}

editor['kevinhwang91/nvim-hlslens'] = {
}

return editor
