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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'mbbill/undotree'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-dispatch'

Plug 'bsdelf/bufferhint'

function! BuildYCM(info)
	if a:info.status == 'installed' || a:info.status == 'updated' || a:info.force
		silent !python ./install.py --clang-completer
	endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do' : function('BuildYCM') }

if v:version >= 800
	Plug 'w0rp/ale'
endif

Plug 'Yggdroot/indentLine'
Plug 'Raimondi/delimitMate'

Plug 'rhysd/vim-clang-format'

Plug 'christoomey/vim-tmux-navigator'

Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'

call plug#end()
