" Leader key

" Map , to leader
let mapleader = ","
let g:mapleader = "."

" Fast saving
nmap <leader>w :w!<CR>

" Remove the Windows ^M when the encodings are messed up
noremap <leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Toggle paste mode
map <leader>pp :setlocal paste!<CR>

" Spell check
" Toggle spell check
map <leader>ss :setlocal spell!<CR>
" Maneuver around the spelling error list
map <leader>sn ]s
map <leader>sp [s
" Add word to dictionary
map <leader>sa zg
" Replace misspelled word with one from the dictionary
map <leader>s? z=

" Cope settings
" Open Cope window
map <leader>qf :botright copen<CR>
" Move around cope window with n and p
map <leader>n :cn<CR>
map <leader>p :cp<CR>
