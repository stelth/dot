local config = {}

function config.nvim_lsp()
    require('modules.completion.lspconfig')
end

function config.nvim_lspinstall()
    require('modules.completion.lspconfig')
end

function config.nvim_trouble()
    require('trouble').setup {
    }
end

function config.completion_nvim()
  vim.g.completion_enable_snippet = 'vim-vsnip'
  vim.g.completion_auto_change_source = 1
end

function config.telescope()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
        vim.cmd [[packadd popup.nvim]]
        vim.cmd [[packadd telescope-fzy-native.nvim]]
    end
    require('telescope').setup {
        defaults = {
            prompt_prefix = '🔭 ',
            prompt_position = 'top',
            selection_caret = " ",
            sorting_strategy = 'ascending',
            results_width = 0.6,
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true
            }
        }
    }
    require('telescope').load_extension('fzy_native')
    require('telescope').load_extension('dotfiles')
end

return config
