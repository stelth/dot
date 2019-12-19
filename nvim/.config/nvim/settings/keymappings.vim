" Key mappings for neovim

" Set leader key
let g:mapleader = ","
let g:maplocalleader = 'm'

nnoremap ; <Nop>
nnoremap m <Nop>
nnoremap , <Nop>

" ctrl-p and ctrl-n to move through lists
cnoremap <C-p> <Up>
cnoremap <C-n> <down>

nnoremap <silent> <bs> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
