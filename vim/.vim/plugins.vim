" Load plugins

if empty( glob( '~/.vim/autoload/plug.vim') )
	silent !mkdir -p ~/.vim/autoload
	silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/bundle/'))

" Base plugins
Plug 'tpope/vim-sensible'

" Helper plugins
Plug 'tpope/vim-dispatch'
Plug 'kana/vim-operator-user'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Editor plugins
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'

" Code plugins
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'w0rp/ale'
Plug 'rhysd/vim-clang-format'

" UI plugins
Plug 'tpope/vim-vinegar'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf.vim'
Plug 'bsdelf/bufferhint'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'

" Misc plugins
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'jceb/vim-orgmode'

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/libclang-python3'
Plug 'zchee/deoplete-clang'
Plug 'Shougo/neoinclude.vim'

call plug#end()
