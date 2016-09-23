" Appearance

" Color scheme stuffs
set background=dark
set t_co=256
colorscheme solarized

set cursorline cursorcolumn "Highlight cursor with crosshair
set hlsearch "Highlight search
set cmdheight=2 "Command bar height
set relativenumber "Relative line numbers
set number "Turn on line numbering
set nolazyredraw "Don't redraw while executing macros
set showmatch "Show matching braces when text indicator is over them
" Don't highlight tabs/spaces
set list lcs=tab:\|\ 
set colorcolumn=80

set cpoptions+=$ "$ to delimit what is being changed

" Stop beeping
set noerrorbells
set vb
set t_vb="."

" Resize horizontal split windows
nnoremap <C-Up> <C-W>-<C-W>-
nnoremap <C-Down> <C-W>+<C-W>+

" Resize vertical split windows
nnoremap <C-Left> <C-W>><C-W>>
nnoremap <C-Right> <C-W><<C-W><

set statusline=%F%m%r%h%w\ [%l/%L,\ %v]\ [%p%%]\ %=[TYPE=%Y]\ [FMT=%{&ff}]\ %{\"[ENC=\".(&fenc==\"\"?&enc:&fenc).\"]\"}
