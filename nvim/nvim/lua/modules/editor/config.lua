local config = {}

function config.vim_cursorword()
    vim.api.nvim_command('augroup user_plugin_cursorword')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,vista let b:cursorword = 0')
    vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
    vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
    vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
    vim.api.nvim_command('augroup END')
end

function config.which_key()
    require('which-key').setup {
        plugins = {
            spelling = {
                enabled = true,
                suggestions = 20
            }
        }
    }
end

return config
