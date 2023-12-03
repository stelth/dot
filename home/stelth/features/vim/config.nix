{...}: ''
  vim9script
  set encoding=utf-8

  scriptencoding utf-8

  # Vimrc 2.0 {{{

  const xdg = {
    XDG_CONFIG_HOME: '~/.config',
    XDG_CACHE_HOME: '~/.cache',
    XDG_DATA_HOME: '~/.local/share',
    XDG_STATE_HOME: '~/.local/state',
  }
  for [key, default] in items(xdg)
    if !has_key(environ(), key)
      setenv(key, expand(default))
    endif
  endfor

  if empty($MYVIMRC)
    $MYVIMRC = expand('<sfile>:p')
  endif

  set runtimepath^=$XDG_CONFIG_HOME/vim
  set runtimepath+=$XDG_DATA_HOME/vim
  set runtimepath+=$XDG_CONFIG_HOME/vim/after

  set viminfo+=n$XDG_STATE_HOME/vim/viminfo

  set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
  set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

  g:netrw_home = $XDG_CACHE_HOME .. '/vim/netrw'

  def EnsureDir(dir: string): void
    if filewritable(dir) != 2
      mkdir(dir, "p")
    endif
  enddef

  for dir_name in ['backup', 'swap', 'undo', 'view']
    EnsureDir($XDG_STATE_HOME .. '/vim/' .. dir_name)
  endfor

  set backupdir=$XDG_STATE_HOME/vim/backup
  set directory=$XDG_STATE_HOME/vim/swap
  set undodir=$XDG_STATE_HOME/vim/undo
  set viewdir=$XDG_STATE_HOME/vim/view
  # }}}

  set background=dark
  colorscheme rosepine

  # => Leader
  g:mapleader = ' '

  # => General Settings
  set clipboard^=unnamed,unnamedplus
  set cursorline
  set hlsearch
  set ignorecase
  set mouse=a
  set nowritebackup
  set number
  set relativenumber
  set signcolumn=yes
  set smartcase
  set smartindent
  set termguicolors
  set undofile
  set updatetime=300

  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  nnoremap <Right> :bnext<CR>
  nnoremap <Left> :bprev<CR>

  # vim-highlightedyank {{{
  g:highlightedyank_highlight_duration = 300
  # }}}


  # fzf-vim {{{
  nmap <leader>hc :Commands<CR>
  nmap <leader>ht :Helptags<CR>
  nmap <leader>hm :Maps<CR>
  nmap <leader>hf :Filetypes<CR>
  nmap <leader>sg :Rg<CR>
  nmap <leader>sb :BLines<CR>
  nmap <leader>sh :History:<CR>
  nmap <leader>sm :Marks<CR>
  nmap <leader>sw :execute 'Rg ' . expand('<cword>')<CR>
  nmap <leader>ff :Files<CR>

  nmap <leader>, :Buffers<CR>
  nmap <leader>/ :Rg<CR>
  nmap <leader>: :History:<CR>

  nmap <leader>gc :Commits<CR>
  nmap <leader>gcc :BCommits<CR>
  nmap <leader>gs :GFiles?<CR>
  # }}}

  # undotree {{{
  g:undotree_ShortIndicators = 1
  g:undotree_WindowLayout = 4
  nnoremap <silent> <leader>u :UndotreeToggle<CR>
  # }}}

  # vim-vsnip {{{
  imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
  smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

  # Expand or jump
  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

  # Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
  # See https://github.com/hrsh7th/vim-vsnip/pull/50
  nmap        s   <Plug>(vsnip-select-text)
  xmap        s   <Plug>(vsnip-select-text)
  nmap        S   <Plug>(vsnip-cut-text)
  xmap        S   <Plug>(vsnip-cut-text)
  # }}}

''
