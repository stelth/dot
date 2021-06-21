local tools = {}
local conf = require('modules.tools.config')

tools['JoosepAlviste/nvim-ts-context-commentstring'] = {event = 'BufReadPre'}

tools['b3nj5m1n/kommentary'] = {
    event = 'BufReadPre',
    setup = conf.kommentary_setup,
    config = conf.kommentary_config
}

tools['liuchengxu/vista.vim'] = {cmd = 'Vista', config = conf.vim_vista}

tools['akinsho/nvim-toggleterm.lua'] = {config = conf.toggleterm}

tools['kdheepak/lazygit.nvim'] = {
    cmd = {'LazyGit', 'LazyGitConfig'},
    setup = conf.lazygit_setup
}

tools['lewis6991/gitsigns.nvim'] = {
    event = {'BufRead', 'BufNewFile'},
    config = conf.gitsigns,
    requires = {'nvim-lua/plenary.nvim', opt = true}
}

return tools
