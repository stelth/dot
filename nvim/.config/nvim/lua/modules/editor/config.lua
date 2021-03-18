local config = {}

function config.vim_eft()
  vim.g.eft_ignorecase = true
end

function config.operator_replace()
  vim.api.nvim_set_keymap("x", "p", "<Plug>(operator-replace)", {silent = true})
end

function config.vim_cursorword()
    vim.api.nvim_command('augroup user_plugin_cursorword')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command(
        'autocmd FileType NvimTree,dashboad,vista let b:cursorword = 0')
    vim.api.nvim_command(
        'autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
    vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
    vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
    vim.api.nvim_command('augroup END')
end

return config
