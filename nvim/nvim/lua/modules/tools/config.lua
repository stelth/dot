local config = {}

function config.vim_vista()
    vim.g['vista#renderer#enable_icon'] = 1
    vim.g.vista_disable_statusline = 1
    vim.g.vista_default_executive = 'nvim_lsp'
    vim.g.vista_echo_cursor_strategy = 'floating_win'

    local wk = require("which-key")

    wk.register({
        ["<leader>"] = {
            v = { "<cmd>Vista<CR>", "Vista" }
        }
    } )
end

function config.fterm()
    require('FTerm').setup()
end

return config
