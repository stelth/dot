local config = {}

function config.nvim_treesitter()
    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
    require('nvim-treesitter.configs').setup {
        ensure_installed = "maintained",
        highlight = {enable = true},
        textobjects = {
            select = {enable = true},
            move = {enable = true, set_jumps = true},
            swap = {enable = true}
        },
        context_commentstring = {enable = true},
        playground = {
            enable = true,
            disable = {},
            updatetime = 25,
            persist_queries = false
        }
    }
end

return config
