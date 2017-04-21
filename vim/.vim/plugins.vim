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

Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'

" Python plugins
" Plug 'klen/python-mode'
" Plug 'davidhalter/jedi-vim'
" Plug 'vim-scripts/indentpython.vim'
" Plug 'tmhedberg/SimpylFold'

Plug 'christoomey/vim-tmux-navigator'

call plug#end()
