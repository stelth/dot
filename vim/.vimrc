""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jason Cox's .vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => Sections: {{{
" 	-> General
" 		-> VIM User Interface
" 		-> Colors and Fonts
" 		-> Files and Backups
" 		-> Text, Tabs, and Indent Related
" 		-> Visual Mode Related
" 		-> Command Mode Related
" 		-> Moving Around, Tabs, and Buffers
" 		-> Status Line
" 		-> Parenthesis / Bracket Expanding
" 		-> General Abbreviations
" 		-> Editing Mappings
" 		-> Spell Check
" 		-> Cope
" 		-> VIM Grep Settings
" 		-> C / C++ Section
" 		-> Protbuf Section
" 		-> Python Section
" 		-> Javascript Section
" 	-> Plugins
" 		-> General Plugins
" 			-> NeoBundle
" 			-> vimproc
" 			-> unite.vim
" 			-> Gundo
" 			-> Vimux
" 			-> base16-vim
" 			-> vim-Fugitive
" 			-> vim-airline
" 			-> vim-indent-guides
" 		-> Coding Plugins
" 			-> clang_complete
" 			-> cscope_macros
" 			-> neocomplcache
" 			-> UltiSnips
"			-> NerdCommenter
"			-> glsl.vim
"			-> unite-outline
"			-> vim-autotags
"			-> unite-tag
"			-> pyclewn
"			-> vim-autotags
" }}}

" => Plugins Included: {{{
" 	-> NeoBundle - https://github.com/Shougo/neobundle.vim
" 		-> Vim plugin manager inspired by vundle
"
" 	-> Vimproc - https://github.com/Shougo/vimproc.vim
" 		-> Requirement for Unite
"
" 	-> unite.vim - https://github.com/Shougo/unite.vim
" 		-> Unite and create user interfaces
"
" 	-> Gundo - https://github.com/vim-scripts/Gundo
" 		->Visualize your undo tree.
"
"	-> Vimux - https://github.com/benmills/vimux
"		-> Easily interact with tmux from vim.
"
"	-> base16-vim - https://github.com/chriskempson/base16-vim
"		-> Base16 for Vim
"
"	-> clang_complete - https://github.com/Rip-Rip/clang_complete
"		-> Vim plugin that uses clang for completing C/C++ code
"
" 	-> CScope Macros - https://github.com/vim-scripts/cscope_macros.vim
" 		-> basic cscope settings and key mappings
"
"	-> neocomplcache - https://github.com/Shougo/neocomplcache
"		-> Ultimate auto-completion system for Vim
"
" 	-> UltiSnips - https://github.com/sirver/UltiSnips
" 		-> The ultimate snippet solution for python enabled vim
"
"	-> NerdCommenter - https://github.com/vim-scripts/The-NERD-Commenter
"		-> Vim plugin for intensely orgasmic commenting
"
"	-> Fugitive - https://github.com/tpope/vim-fugitive
"		-> A git wrapper so awesome, it should be illegal
"
"	-> glsl.vim - https://github.cim/vim-scripts/glsl.vim
"		-> Syntax file for GLSL
"
"	-> vim-airline - https://github.com/bline/vim-airline
"		-> lean and mean statusline for vim that's light as air
"
"	-> unite-outline - https://github.com/shougo/unite-outline
"		-> outline source for unite.vim
"
"	-> vim-autotags - https://github.com/basilgor/vim-autotags
"		-> vim plugin for easy ctags and cscope handling in a separate directory
"
"	-> unite-tag - https://github.com/tsukkee/unite-tag
"		-> tags source for unite.vim
"
"	-> vim-indent-guides - https://github.com/nathanaelkane/vim-indent-guides
"		-> A Vim plugin for visually displaying indent levels in code
"
"	-> pyclewn - https://github.com/xieyu/pyclewn
"		-> allows using vim as a front end to gdb
"
"	-> vim-autotags - https://github.com/basilgor/vim-autotags
"		-> vim plugin for easy ctags and cscope handling in a separate directory
" }}}


if has('vim_starting') 
	set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" => General {{{

" => Vim Generic Settings {{{
" Sets how many lines VIM has to remember
set history=700

" Set to auto read when a file is changed from the outside
set autoread

" Non vi compatible mode
set nocompatible

" Map , for extra key combinations
let mapleader = ","
let g:mapleader = ","

" map ctrl-e to do what comma used to do
nnoremap <C-e> = ,
vnoremap <C-e> = ,

" Fast saving
nmap <leader>w :w!<CR>
" Fast editing of .vimrc
nmap <leader>e :e! ~/.vimrc<CR>

" When vimrc is edited, reload it
autocmd! bufwritepost ~/.vimrc source ~/.vimrc

" change .viminfo directory
set viminfo+=n~/.vim.local/.viminfo

function! MySys()
	return "linux"
endfunc

" Installed Plugins {{{
" General Plugins {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Gundo'
NeoBundle 'benmills/vimux'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'bling/vim-airline'
NeoBundle 'nathanaelkane/vim-indent-guides'
" }}}

" Programming Plugins {{{
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'cscope_macros.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'SirVer/ultisnips.git'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'vim-scripts/glsl.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'basilgor/vim-autotags'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'xieyu/pyclewn'
NeoBundle 'dag/vim2hs'
" }}}

" }}}

" Enable filetype plugin
filetype plugin indent on

NeoBundleCheck

nnoremap <silent> <F5> :%!astyle<CR>

nmap <esc>[A <up>
nmap <esc>[B <down>
nmap <esc>[C <right>
nmap <esc>[D <left>

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>

nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>

imap jj <esc>
noremap <expr> <CR> 0 < v:count ? 'G' : '<CR>'

set cursorline cursorcolumn
set cc=80
" }}}

" => VIM User Interface {{{

" Set 7 lines to the cursor when moving vertical
set so=7

" Turn on WiLd menu
set wildignorecase
set wildmode=list:longest,list:full
set wildmenu

" Always show current position
set ruler

" The commandbar height
set cmdheight=2

" Change buffer without saving
set hid

" Line numbering
set number

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase
set smartcase

" Highlight search things
set hlsearch

set showfulltag

" Make search act like modern browsers
set incsearch
" Don't redraw while executing macros
set lazyredraw

" Set magic on for regex's
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink
set mat=2

" No sound on errors
set noerrorbells
set novisualbell
set vb t_vb=
set tm=100

set showcmd
set showmode

set timeoutlen=500

" Don't highlight tabs/spaces
set list lcs=tab:\|\ 

au VimResized * exe "normal! \<c-w>="

" resize horzontal split window
nnoremap <C-Up> <C-W>-<C-W>-
nnoremap <C-Down> <C-W>+<C-W>+
" resize vertical split window
nnoremap <C-Left> <C-W>><C-W>>
nnoremap <C-Right> <C-W><<C-W><
" }}}

" => Colors and Fonts {{{

" Enable syntax highlighting
syntax on

set formatoptions=tcqlron
set cinoptions=:0,l1,t0,g0
" Set font according to system
if MySys() == "mac"
	set gfn=Menlo:h14
	set shell=/bin/bash
elseif MySys() == "windows"
	set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
	set shell=/bin/zsh
endif

let base16colorspace=256

if has("gui_running")
	set guioptions-=T
	set t_Co=256
	set background=dark
	colorscheme base16-default
else
	set t_Co=256
	set background=dark
	colorscheme base16-default
endif

set encoding=utf8
try
	lang en_US
catch

endtry

" Default file types
set ffs=unix,dos,mac

set clipboard=unnamed
" }}}

" => Files and Backups {{{
" Turn backup off
set nobackup
set nowb
set swapfile
set directory=/tmp


" Persistent undo
try
	if MySys() == "windows"
		set undodir=C:\Windows\Temp
	else
		set undodir=~/.vim.local/.vim_runtime/undodir
	endif

	set undofile
catch

endtry
" }}}

" => Text, Tab, and Indent Related {{{
set noexpandtab
set shiftwidth=8
set tabstop=8
set softtabstop=0
set smarttab

set lbr
set tw=500

" Auto indent
set ai
" Smart indent
set si
" Wrap lines
set wrap

" $ for what is being changed
set cpoptions+=$

set virtualedit=all

" }}}

" => Visual Mode Related {{{
" In visual mode, press * or # for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

function! VisualSearch(direction) range
	let l:saved_reg = @"
	execute "normal! vgvy"

	let l:pattern = escape(@", '\\/.*$^~[]')
	let l:pattern = substitute(l:pattern, "\n$", "", "")

	if a:direction == 'b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction == 'gv'
		call CmdLine("vimgrep " . '/' . l:pattern '/' . ' **/*.')
	endif

	let @/ = l:pattern
	let @" = l:saved_reg
endfunction
" }}}

" => Command Mode Related {{{
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<CR>

" $q is super useful when browsing on the command line
cno $q <C-\>DeleteTilSlash()<CR>

" Bash like keys for the command line
cnoremap <C-A> 	<Home>
cnoremap <C-E> 	<End>
cnoremap <C-K> 	<C-U>

cnoremap <C-P> 	<Up>
cnoremap <C-N> 	<Down>

func! Cwd()
	let cwd = getcwd()
	return "e " . cwd
endfunc

func! DeleteTilSlash()
	let g:cmd = getcmdline()
	if MySys() == "linux" || MySys() == "mac"
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
	else
		let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
	endif
	if g:cmd == g:cmd_edited
		if MySys() == "linux" || MySys() == "mac"
			let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
		else
			let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
		endif
	endif
	return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunc
" }}}

" => Moving Around, Tabs, and Buffers {{{
nmap <silent> <BS> :nohlsearch<CR>

" Smart way to move btw. windows / buffers
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<CR>
map <leader>bw :bw<CR>

" Close all the buffers
map <leader>ba :1,300 bd!<CR>

" Tab configuration
map <leader>tn :tabnew<CR>
map <leader>te :tabedit
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum = bufnr("%")
	let l:alternateBufNum = bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%") == l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction

" Specify the behavior when switching between buffers
try
	set switchbuf=usetab
	set stal=2
catch

endtry
" }}}

" => Parenthesis / Bracket Expansion {{{
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i
" }}}

" => General Abbreviations {{{
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<CR>
" }}}

" => Editing Mappings {{{
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-j> :m'>+<CR>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<CR>`>my`<mzgv`yo`z

if MySys() == "mac"
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm

" Toggle paste mode
map <leader>pp :setlocal paste!<CR>
" }}}

" => Spell Check {{{
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<CR>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=
" }}}

" => Cope {{{
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>qf :botright copen<CR>
map <leader>n :cn<CR>
map <leader>p :cp<CR>
" }}}

" => Folding {{{
set foldlevelstart=0

" "Refocus" folds
nnoremap ,z zMzvzz

" Make zO recursively open whatever top level fold we're in, no matter where the 
" cursor happens to be
nnoremap zO zCzO

function! MyFoldText( ) " {{{
	let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{{\d*\s*', '', 'g') . ' '
	let lines_count = v:foldend - v:foldstart + 1
	let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
	let foldchar = '·'
	let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	let foldtextend = lines_count_text . repeat(foldchar, 8)
	let length = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g'))
	return foldtextstart . repeat(foldchar, winwidth(0)-length) . foldtextend
endfunction " }}}
set foldtext=MyFoldText()

nmap <leader>ff :call <SID>ToggleFold()<CR>
function! s:ToggleFold()
	if &foldmethod == 'marker'
		let &l:foldmethod = 'syntax'
	else
		let &l:foldmethod = 'marker'
	endif
	echo 'foldmethod is now ' . &l:foldmethod
endfunction

set foldenable
set foldcolumn=0
set foldmethod=syntax
" }}}

" => VIM Grep Settings {{{
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated .git'
set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
set grepformat=%f:%l:%c:%m
" }}}

" => C / C++ Section {{{
" cscope file-searching alternative
function! SetCscope()
	let curdir = getcwd()

	while !filereadable("cscope.out") && getcwd() != "/"
		cd ..
	endwhile

	if filereadable("cscope.out")
		execute "cs add " . getcwd() . "/cscope.out"
	endif

	execute "cd " . curdir
endfunction

call SetCscope()

let &errorformat="%-G%.%#libtool%.%#version-info%.%#,".&errorformat
map <F7> :make<CR>

" }}}

" => Protobuf Section {{{
augroup filetype
	au! BufRead,BufNewFile *.proto setfiletype proto
augroup END
" }}}

" => Python Section {{{
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f #--- PH ----------------------------------------------<esc>FP2xi
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def
au FileType python set expandtab
" }}}

" => Javascript Section {{{
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
	setl foldmethod=syntax
	setl foldlevelstart=1
	syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

	function! FoldText()
		return substitute(getline(v:foldstart), '{.*', '{...}', '')
	endfunction
	setl foldtext=FoldText()
endfunction
" }}}
" }}}

" => Plugins {{{

" => unite.vim {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#set_profile('files', 'smartcase', 1)

let g:unite_data_directory='~/.vim.local/cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_file_rec_max_cache_files=5000
let g:unite_prompt='>> '

let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opts=''

function! s:unite_settings()
	nmap <buffer> Q <plug>(unite_exit)
	nmap <buffer> <esc> <plug>(unite_exit)
	imap <buffer> <esc> <plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()

nnoremap [unite] <nop>
nmap <space> [unite]

nnoremap <silent> [unite]<space> :<C-u>Unite -resume -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr>
nmap <silent> <C-p> [unite]<space>
nnoremap <silent> [unite]f :<C-u>Unite -resume -auto-resize -buffer-name=files file_rec<cr>
nnoremap <silent> [unite]r :<C-u>Unite -auto-resize -buffer-name=mru -start-insert file_mru<cr>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -auto-resize -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=tags tag<cr>
" }}}

" => Gundo {{{
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
nnoremap <F6> :GundoToggle<CR>
" }}}

" => Vimux {{{
map <leader>rp :VimuxPromptCommand<CR>
map <leader>rl :VimuxRunLastCommand<CR>
map <leader>ri :VimuxInspectRunner<CR>
map <leader>rx :VimuxClosePanes<CR>
map <leader>rs :VimuxInterruptRunner<CR>
" }}}

" => clang_complete {{{
let g:clang_auto_select = 0
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1
let g:clang_complete_hl_errors = 1
let g:clang_close_preview = 1
let g:clang_use_library = 1
let g:clang_library_path = '/usr/lib64/llvm'
let g:clang_snippets = 1
let g:clang_snippets_engine = 'ultisnips'
let g:clang_complete_macros = 1
let g:clang_complete_patterns = 1
" }}}

" => CScope Macros {{{

" }}}

" => neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

if !exists( 'g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns[ 'default' ] = '\h\w'

inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()


if !exists( 'g:neocomplcache_force_omni_patterns' )
	let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" }}}

" => UltiSnips {{{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" => NerdCommenter {{{

" }}}

" => glsl.vim {{{
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl set filetype=glsl

" }}}

" => vim-airline {{{
let g:airline_theme='base16'
let g:airline_powerline_fonts=1
let g:airline_enable_branch=1
set laststatus=2
set noshowmode
" }}}
"
" => vim-autotags {{{
let g:autotags_no_global = 1
let g:autotagsdir=$HOME."/.tags"
" }}}
