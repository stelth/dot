" Load plugins

if empty( glob( '~/.vim/autoload/plug.vim') )
	silent !mkdir -p ~/.vim/autoload
	silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/bundle/'))

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'uarun/vim-protobuf', { 'for' : ['proto'] }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sensible'
Plug 'mbbill/undotree'

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
		silent !python ./install.py --clang-completer
	endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do' : function('BuildYCM'), 'for' : ['c','cpp'] }
autocmd! User YouCompleteMe if !has('vim_starting') | call youcompleteme#Enable() | endif
Plug 'ludovicchabant/vim-gutentags', { 'for' : ['cpp', 'c'] }
Plug 'jnurmine/Zenburn'
Plug 'ctrlpvim/ctrlp.vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'

call plug#end()
