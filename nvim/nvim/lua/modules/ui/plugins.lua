local ui = {}
local conf = require('modules.ui.config')

ui['folke/tokyonight.nvim'] = {
    config = conf.tokyonight
}

ui['glepnir/galaxyline.nvim'] = {
    branch = 'main',
    config = conf.galaxyline
}

ui['lukas-reineke/indent-blankline.nvim'] = {
    event = 'BufRead',
    branch = 'lua',
    config = conf.indent_blankline
}

ui['akinsho/nvim-bufferline.lua'] = {
    config = conf.nvim_bufferline,
    requires = 'kyazdani42/nvim-web-devicons'
}

ui['kyazdani42/nvim-tree.lua'] = {
    cmd = {'NvimTreeToggle', 'NvimTreeOpen'},
    config = conf.nvim_tree,
    requires = 'kyazdani42/nvim-web-devicons'
}

ui['lewis6991/gitsigns.nvim'] = {
    event = {'BufRead', 'BufNewFile'},
    config = conf.gitsigns,
    requires = {'nvim-lua/plenary.nvim', opt = true}
}

ui['folke/todo-comments.nvim'] = {
    event = 'BufReadPre',
    config = conf.todo_comments
}

return ui
