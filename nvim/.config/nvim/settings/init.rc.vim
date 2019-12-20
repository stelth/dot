let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
	\ && (has('mac') || has('macunix') || has('gui_macvim')
	\ ||  (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

let g:mapleader = ','
let g:maplocalleader = 'm'

nnoremap ; <NOP>
nnoremap m <NOP>
nnoremap , <NOP>

if IsWindows()
  set shellslash
endif

let $CACHE = expand('~/.cache')

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

if has('gui_running')
  set guioptions=Mc
endif
