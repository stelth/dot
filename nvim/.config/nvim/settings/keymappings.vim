" Key mappings for neovim

" Set leader key
let mapleader=","

" ctrl-p and ctrl-n to move through lists
cnoremap <C-p> <Up>
cnoremap <C-n> <down>

nnoremap <silent> <bs> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
