set ignorecase
set smartcase
set incsearch
set nohlsearch
set wrapscan

set smarttab
set expandtab
set shiftwidth=4
set shiftround

set autoindent smartindent

function! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal tabstop=8
  setlocal noexpandtab
endfunction

set modelines=0
set nomodeline
autocmd MyAutoCmd BufRead,BufWritePost *.txt setlocal modelines=5 modeline

if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
  else
    set clipboard& clipboard+=unnamed
  endif
endif

if has('patch-8.2.0592')
  set backspace=indent,eol,nostop
else
  set backspace=indent,eol,start
endif

set matchpairs+=<:>

set hidden

set foldenable
set foldmethod=indent
if has('nvim-0.5.1')
  set foldcolumn=auto:1
else
  set foldcolumn=1
endif
set fillchars=vert:\|
set commentstring=%s

autocmd MyAutoCmd TextChangedI,TextChanged *
      \ if &l:foldenable && &l:foldmethod !=# 'manual' |
      \   let b:foldmethod_save = &l:foldmethod |
      \   let &l:foldmethod = 'manual' |
      \ endif
autocmd MyAutoCmd BufWritePost *
      \ if &l:foldmethod ==# 'manual' && exists('b:foldmethod_save') |
      \   let &l:foldmethod = b:foldmethod_save |
      \   execute 'normal! zx' |
      \ endif

if has('*FoldCCtext')
  set foldtext=FoldCCtext()
endif

set grepprg=grep\ -inH

set isfname-==

set timeout timeoutlen=1000 ttimeoutlen=100

set updatetime=100

set directory-=.

set undofile

let &g:undodir = &directory

set virtualedit=block

set keywordprg=:help

autocmd MyAutoCmd InsertLeave *
      \ if &paste | setlocal nopaste | echo 'nopaste' | endif |
      \ if &l:diff | diffupdate | endif

autocmd MyAutoCmd InsertLeave * if &l:diff | diffupdate | endif

if has('patch-8.1.0360')
  set diffopt=internal,algorithm:patience,indent-heuristic
endif

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary(expand('<afile>:p:h'), v:cmdbang)
function! s:mkdir_as_necessary(dir, force) abort
  if !isdirectory(a:dir) && &l:buftype == '' &&
	\ (a:force || input(printf('"%s" does not exist. Create? [y,N]',
	\   a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

set list
if IsWindows()
  set listchars=tab:>-,trail:-,precedes:<
else
  set listchars=tab:>\ ,trail:-,precedes:<,nbsp:%
endif
set laststatus=2
set cmdheight=2
set title
set titlelen=95
let &g:titlestring = "
      \ %{expand('%:p:~:.')}%(%m%r%w%)
      \ %<\(%{fnamemodify(getcwd(), ':~')}\) - VIM"
set showtabline=0

let &g:statusline = "%{winnr('$')>1?'['.winnr().'/'.winnr('$')"
      \ . ".(winnr('#')==#winnr()?'#':'').']':''}\ "
      \ . "%{(&previewwindow?'[preview] ':'')."
      \ . ".expand('%:t')==#''?expand('%'):expand('%:t')}"
      \ . "\ %=%{(winnr('$')==1 || winnr('#')!=winnr()) ?
      \ '['.(&filetype!=#''?&filetype.',':'')"
      \ . ".(&fenc!=''?&fenc:&enc).','.&ff.']' : ''}"
      \ . "%m%{printf('%'.(len(line('$'))+2).'d/%d',line('.'),line('$'))}"

set linebreak
set showbreak=\
set breakat=\ \|;:,!?

set whichwrap+=h,l,<,>,[,],b,s,~
if exists('+breakindent')
  set breakindent
  set wrap
else
  set nowrap
endif

set shortmess=aTI

set noshowmode
if has('patch-7.4.314')
  set shortmess+=F
endif

set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

set t_vb=
set novisualbell
set belloff=all

if has('nvim')
  set wildmenu
  set wildmode=full
  set wildoptions+=pum
else
  set nowildmenu
  set wildmode=list:longest,full
endif

let g:did_install_default_menus = 1

set completeopt=menuone
if exists('+completepopup')
  set completeopt+=popup
  set completepopup=height:4,width:60,highlight:InfoPopup
endif
set complete=.
set pumheight=20

set report=0

set nostartofline

set splitbelow
set splitright
set winwidth=30
set winheight=1
set noequalalways

set previewheight=8
set helpheight=12

set ttyfast

set display=lastline

set conceallevel=2 concealcursor=niv

set colorcolumn=79

if exists('+previewpopup')
  set previewpopup=height:10,width:60
endif
