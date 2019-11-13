if &compatible
	set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
	call dein#begin('~/.cache/dein')

	" Helper plugins
	call dein#add('christoomey/vim-tmux-navigator')

	" Editor plugins
	call dein#add('tpope/vim-commentary')

	" Code plugins
	call dein#add('Shougo/neosnippet.vim')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('Shougo/neoinclude.vim')
	call dein#add('Shougo/deoplete-clangx')
	call dein#add('deoplete-plugins/deoplete-jedi')

	" UI Plugins
	call dein#add('arcticicestudio/nord-vim')
	call dein#add('itchyny/lighgline.vim')

	" Misc plugins
	call dein#add('tpope/vim-fugitive')

	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable
