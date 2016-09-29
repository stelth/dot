" Misc. Vim Settings

" Search options
set viminfo+=n~/.vim.local/.viminfo
set ignorecase "Ignore case when searching
set magic "Set magic on, for regular expressions

" Turn on WiLD menu
set wildignorecase
set wildmode=list:longest,list:full

" Turn backup off
set nobackup
set nowb
set noswapfile

" Tab expansion
set noexpandtab
set shiftwidth=8
set tabstop=8
set softtabstop=0

set wrap "Wrap lines

set hidden "Don't unload buffer when it is abandoned

set clipboard=unnamed "Use system clipboard

set spr "split right

au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
