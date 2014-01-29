" Remap Commands

" work around xinput weirdness
nmap <esc>[A <up>
nmap <esc>[B <down>
nmap <esc>[C <right>
nmap <esc>[D <left>

" Vim hard mode
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

" Vim hard mode
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>

" Vim hard mode
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

" ctrl-p and ctrl-n to move through lists
cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" use backspace to remove search highlights
nmap <silent> <BS> :nohlsearch<CR>

" ctrl + movement keys to move between buffers / windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" format source code
nnoremap <silent> <F5> :%!astyle<CR>
