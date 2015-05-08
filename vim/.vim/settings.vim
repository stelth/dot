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

set clipboard=unnamedplus "Use system clipboard

set spr "split right
set sb "split below
