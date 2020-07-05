" Neovim settings

if has('vim_starting') && empty(argv())
  syntax off
endif

if IsMac()
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/local/bin/python3'
elseif IsLinux()
  let g:python_host_prog = '/usr/bin/python2'
  let g:python3_host_prog = '/usr/bin/python3'
endif

if exists('&inccommand')
  set inccommand=nosplit
endif

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor

autocmd MyAutoCmd TermOpen * setlocal modifiable
autocmd MyAutoCmd TermClose * buffer #

let g:terminal_scrollback_buffer_size = 3000

autocmd MyAutoCmd TextYankPost * silent! lua require'vim.highlight'.on_yank('IncSearch', 150)
