" Misc. Vim Settings

set history=700 "Set how many lines of history VIM has to remember
set ttimeoutlen=50 "Speed up 0 etc in the terminal
set autoread "Set to auto read when a file is changed from the outside
set viminfo+=n~/.vim.local/.viminfo
set bs=2 "Allow backspace
set scrolloff=7 "Start scrolling 6 lines before edge of viewport

" Search options
set ignorecase "Ignore case when searching
set incsearch "Make search act like search in modern browsers
set magic "Set magic on, for regular expressions

" Turn on WiLD menu
set wildignorecase
set wildmode=list:longest,list:full
set wildmenu

set ffs=unix "Default filetype

set clipboard=unnamed "Use X clipboard

filetype plugin on
filetype indent on
filetype on
syntax enable

" Turn backup off
set nobackup
set nowb
set noswapfile

" Tab expansion
set noexpandtab
set shiftwidth=8
set tabstop=8
set softtabstop=0
set smarttab

set wrap "Wrap lines
