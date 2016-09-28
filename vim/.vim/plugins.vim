" Load plugins

if empty( glob( '~/.vim/autoload/plug.vim') )
	silent !mkdir -p ~/.vim/autoload
	silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/bundle/'))

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'mbbill/undotree'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-dispatch'

Plug 'altercation/vim-colors-solarized'
Plug 'ctrlpvim/ctrlp.vim'

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
		silent !python ./install.py --clang-completer
	endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do' : function('BuildYCM'), 'for' : ['c','cpp'] }
autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif

Plug 'klen/python-mode'
Plug 'davidhalter/jedi-vim'

call plug#end()
