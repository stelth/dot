" Remap Commands

let mapleader="\<space>"
let maplocalleader="\\"

" work around xinput weirdness
nmap <esc>[A <up>
nmap <esc>[B <down>
nmap <esc>[C <right>
nmap <esc>[D <left>

" ctrl-p and ctrl-n to move through lists
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" format source code
nnoremap <silent> <F5> :%!clang-format<CR>

nnoremap <silent> <bs> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
