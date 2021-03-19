local config = {}

function config.far()
  vim.g['far#source'] = 'rg'
end

function config.vim_vista()
  vim.g['vista#renderer#enable_icon'] = 1
  vim.g.vista_disable_statusline = 1
  vim.g.vista_default_executive = 'nvim_lsp'
  vim.g.vista_echo_cursor_strategy = 'floating_win'
end

return config
