" Load plugins

if empty( glob( '~/.vim/autoload/plug.vim') )
	silent !mkdir -p ~/.vim/autoload
	silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/bundle/'))

Plug 'Shougo/vimproc', { 'do' : 'make -f make_unix.mak' }

Plug 'Shougo/unite.vim'
Plug 'Shougo/neomru.vim'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/unite-outline'
Plug 'tikhomirov/vim-glsl'
Plug 'vhdirk/vim-cmake'
Plug 'uarun/vim-protobuf', { 'for' : ['proto'] }
Plug 'wikitopian/hardmode'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-sensible'
Plug 'mbbill/undotree'

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
		silent !./install.sh --clang-completer --system-libclang --system-boost
	endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do' : function('BuildYCM') }
Plug 'Valloric/ListToggle'
Plug 'ervandew/supertab'
Plug 'ludovicchabant/vim-gutentags', { 'for' : ['cpp', 'c'] }
Plug 'jnurmine/Zenburn'
Plug 'bling/vim-airline'
Plug 'benmills/vimux'
Plug 'octol/vim-cpp-enhanced-highlight'

Plug 'git@github.com:Stelth300/stealth-syntax.git'

call plug#end()
