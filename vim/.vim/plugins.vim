" Load plugins

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
	\ 'build' : {
	\ 	'windows' : 'make -f make_mingw32.mak',
	\	'cygwin' : 'make -f make_cygwin.mak',
	\	'mac' : 'make -f make_mak.mak',
	\	'unix' : 'make -f make_unix.mak',
	\	},
	\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'SirVer/ultisnips.git'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tikhomirov/vim-glsl'
NeoBundle 'vhdirk/vim-cmake'
NeoBundle 'uarun/vim-protobuf'
NeoBundle 'wikitopian/hardmode'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'mbbill/undotree'
NeoBundle 'Valloric/YouCompleteMe' , {
            \ 'build' : {
            \    'unix' : './install.sh --clang-completer --system-libclang'
            \ },
	    \ }

NeoBundleCheck
