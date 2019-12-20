" Key mappings for neovim

" Use <C-Space>
nmap <C-Space> <C-@>
cmap <C-Space> <C-@>

nmap <Space> [Space]
nnoremap [Space] <NOP>

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

command! WordCount echo strchars(join(getline(1, '$')))
