let $CACHE = expand('~/.cache')

let g:mapleader = ','
let g:maplocalleader = 'm'

nnoremap ; <NOP>
nnoremap m <NOP>
nnoremap , <NOP>

if !isdirectory(expand($CACHE))
	call mkdir(expand($CACHE), 'p')
endif

" Load dein
let s:dein_dir = finddir('dein.vim', '.;')
if s:dein_dir != '' || &runtimepath !~ '/dein.vim'
	if s:dein_dir == '' && &runtimepath !~ '/dein.vim'
		let s:dein_dir = expand('$CACHE/dein')
					\. '/repos/github.com/Shougo/dein.vim'
		if !isdirectory(s:dein_dir)
			execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
		endif
	endif
	execute 'set runtimepath^=' . substitute(
				\ fnamemodify(s:dein_dir, ':p'), '/$', '', '')
endif
