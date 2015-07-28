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

" run command in tmux pane
nnoremap <silent> <F7> :VimuxPromptCommand<CR>

map <BS> :set hls!<CR>
imap <BS> :set hls!<CR>
vmap <BS> :set hls!<CR>
