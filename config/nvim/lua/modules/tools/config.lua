local config = {}

function config.vim_vista()
    vim.g['vista#renderer#enable_icon'] = 1
    vim.g.vista_disable_statusline = 1
    vim.g.vista_default_executive = 'nvim_lsp'
    vim.g.vista_echo_cursor_strategy = 'floating_win'
end

function config.toggleterm()
    require('toggleterm').setup {direction = 'float'}
    vim.api.nvim_command(
        'autocmd TermEnter term://*toggleterm#* tnoremap <silent><leader>ut <C-\\><C-n>:exe v:count1 "ToggleTerm"<CR>')
end

function config.kommentary_setup()
    vim.g.kommentary_create_default_mappings = false
end

function config.kommentary_config()
    require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
        use_consistent_indentation = true,
        ignore_whitespace = true
    })
end

function config.lazygit_setup()
    vim.g.lazygit_floating_window_use_plenary = 1
    vim.g.lazygit_use_neovim_remote = 0
end

return config
