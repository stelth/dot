" Load plugins

if empty( glob( '~/.vim/autoload/plug.vim') )
	silent !mkdir -p ~/.vim/autoload
	silent !curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/bundle/'))

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
		silent !python ./install.py --clang-completer
	endif
endfunction

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
Plug 'Valloric/YouCompleteMe', { 'do' : function('BuildYCM') }
if v:version >= 800
	Plug 'w0rp/ale'
endif
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

call plug#end()
