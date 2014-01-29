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
NeoBundle 'Gundo'
NeoBundle 'benmills/vimux'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'bling/vim-airline'
NeoBundle 'rking/ag.vim'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'cscope_macros.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'SirVer/ultisnips.git'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-scripts/glsl.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'basilgor/vim-autotags'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'vhdirk/vim-cmake'
NeoBundle 'uarun/vim-protobuf'
NeoBundle 'wikitopian/hardmode'

NeoBundleCheck
