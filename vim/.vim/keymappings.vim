" Remap Commands

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

" clear search highlight
nnoremap <silent> <C-c> :nohlsearch<CR><C-c>

" open tmux pane
nnoremap <silent> <F7> :VimuxPromptCommand<CR>
