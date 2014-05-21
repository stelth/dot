" Basic Setup

set nocompatible "be iMproved

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim/ "where the bundles are located
endif

call neobundle#rc(expand('~/.vim/bundle/')) "neobundle setup
