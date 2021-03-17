local editor = {}
local conf = require('modules.editor.config')

editor['rhysd/accelerated-jk'] = {opt = true}

editor['itchyny/vim-cursorword'] = {
    event = {'BufReadPre', 'BufNewFile'},
    config = conf.vim_cursorword
}

editor['hrsh7th/vim-eft'] = {
    opt = true,
    config = function() vim.g.eft_ignorecase = true end
}

editor['kana/vim-operator-replace'] = {
    keys = {{'x', 'p'}},
    config = function()
        vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)",
                                {silent = true})
    end,
    requires = 'kana/vim-operator-user'
}

editor['rhysd/vim-operator-surround'] = {
    event = 'BufRead',
    requires = 'kana/vim-operator-user'
}

editor['kana/vim-niceblock'] = {opt = true}

return editor
