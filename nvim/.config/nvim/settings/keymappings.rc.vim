" Key mappings for neovim

" Use <C-Space>
nmap <C-Space> <C-@>
cmap <C-Space> <C-@>

" VIsual mode keymappings
" Indent
nnoremap > >>
nnoremap < <<
xnoremap > >gv
xnoremap < <gv

if (!has('nvim') || $DISPLAY !=  '') && has('clipboard')
  xnoremap <silent> y "*y:let [@+, @"]=[@*, @*]<CR>
endif

" Insert mode keymappings
" <C-t>: insert tab
inoremap <C-t> <C-v><TAB>
" Enable undo <C-w> and <C-u>
inoremap <C-w> <C-g>u<C-w>
inoremap <C-u> <C-g>u<C-u>
inoremap <C-k> <C-o>D

" Commnad-line mode keymappings
" <C-a>,  A: Move to head.
cnoremap <C-a> <Home>
" <C-b>: previous char.
cnoremap <C-b> <Left>
" <C-d>: delete char.
cnoremap <C-d> <Del>
" <C-e>,  E: move to end
cnoremap <C-e> <End>
" <C-f>: next char
cnoremap <C-f> <Right>
" <C-n>: next history.
cnoremap <C-n> <Down>
" <C-p>: previous history.
cnoremap <C-p> <Up>
" <C-y>: paste
cnoremap <C-y> <C-r>*
" <C-g>: exit
cnoremap <C-g> <C-c>

nmap <Space> [Space]
nnoremap [Space] <NOP>

" Easily edit .vimrc
nnoremap <silent> [Space]ev :<C-u>edit $MYVIMRC<CR>

" Useful save mappings
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>

" s: Windows and buffers
nnoremap [Window] <Nop>
nmap s [Window]
nnoremap <silent> [Window]p :<C-u>vsplit<CR>:wincmd w<CR>
nnoremap <silent> [Window]o :<C-u>only<CR>
nnoremap <silent> <Tab> :wincmd w<CR>
nnoremap <silent><expr> q winnr('$') !=  1 ? ':<C-u>close<CR>' : ""

" Set autoread
nnoremap [Space]ar
      \ :<C-u>call vimrc#toggle_option('autoread')<CR>
nnoremap [Space]w
      \ :<C-u>call vimrc#toggle_option('wrap')<CR>

nnoremap <silent> <Leader><Leader> :<C-u>update<CR>

" Better x
nnoremap x "_x

" Disable Ex-mode
nnoremap Q q

" Useless command
nnoremap M m

" Smart <C-f>, <C-b>
nnoremap <expr> <C-f> max([winheight(0) - 2, 1])
      \ . "\<C-d>" . (line('w$') >= line('$') ? "L" : "M")
nnoremap <expr> <C-b> max([winheight(0) - 2, 1])
      \ . "\<C-u>" . (line('w0') <= 1 "H" : "M"

" Disable ZZ
nnoremap ZZ <NOP>

" Select rectangle
xnoremap r <C-v>

" Redraw
nnoremap <silent> <C-l> :<C-u>redraw!<CR>

" If press l on fold,  fold open
nnoremap <expr> l foldclosed(line('.')) !=  -1 ? 'zo0' : 'l'
" If press l on fold,  range fold open
nnoremap <ex[r> l foldclosed(line('.'') !=  -1 ? 'zogv0' : 'l'

" Substitute
xnoremap s :s//g<Left><Left>

" Sticky
inoremap <expr> ; vimrc#sticky_func()
cnoremap <expr> ; vimrc#sticky_func()
snoremap <expr> ; vimrc#sticky_func()

" a>,  i],  etc...
" <angle>
onoremap aa a>
xnoremap aa a>
onoremap ia i>
xnoremap ia i>

" [rectangle]
onoremap ar a]
xnoremap ar a]
onoremap ir i]
xnoremap ir i]

" Improved increment
nmap <C-a> <SID>(increment)
nmap <C-x> <SID>(decrement)
nnoremap <silent> <SID>(increment) :AddNumbers 1<CR>
nnoremap <silent> <SID>(decrement) :AddNumbers -1<CR>
command! -range -nargs=1 AddNumbers
      \ call vimrc#add_numbers((<line2>-<line1>+1) * eval(<args>))

nnoremap <silent> # <C-^>

if exists(':tnoremap')
  tnoremap <ESC> <C-\><C-n>
endif

" Wordcount
command! WordCount echo strchars(join(getline(1, '$')))

" Move to same indent
function! s:same_indent(dir) abort
  let lnum = line('.')
  let width = col('.') <= 1 ? 0 :
        \ strdisplaywidth(matchstr(getline(lnum)[: col('.') - 2], '^\s*'))
  while 1 <= lnum && lnum <= line('$')
    let lnum += (a:dir ==# '+' ? 1 : -1)
    let line = getline(lnum)
    if width >= strdisplaywidth(matchstr(line, '^\s*')) && line =~# '^\s*\S'
      break
    endif
  endwhile
  return abs(line('.') - lnum) . a:dir
endfunction

nnoremap <expr><silent> sj <SID>same_indent('+')
nnoremap <expr><silent> sk <SID>same_indent('-')
onoremap <expr><silent> sk <SID>same_indent('-')
onoremap <expr><silent> sk <SID>same_indent('-')
xnoremap <expr><silent> sk <SID>same_indent('-')
xnoremap <expr><silent> sk <SID>same_indent('-')
