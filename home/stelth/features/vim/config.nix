{
  config,
  pkgs,
  lib,
  ...
}: let
  color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
in ''
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

  packadd termdebug

  source ${color}

  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

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

  # vim-cmake {{{
  g:cmake_link_compile_commands = 1
  # }}}

  # vim-vsnip {{{
  imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
  smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

  # Expand or jump
  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

  def! g:WhitespaceOnly(): bool
    return strpart(getline('.'), col('.') - 2, 1) =~ '^\s*$'
  enddef

  def! g:LspCleverTab(): string
    return pumvisible() ? "\<c-n>" : vsnip#jumpable(1) ? "\<Plug>(vsnip-jump-next)" : g:WhitespaceOnly() ? "\<tab>" : "\<c-n>"
  enddef

  def! g:LspCleverSTab(): string
    return pumvisible() ? "\<c-p>" : vsnip#jumpable(-1) ? "\<Plug>(vsnip-jump-prev)" : g:WhitespaceOnly() ? "\<s-tab>" : "\<c-p>"
  enddef

  # Jump forward or backward
  inoremap <expr> <Tab> g:LspCleverTab()
  snoremap <expr> <Tab> g:LspCleverTab()
  inoremap <expr> <S-Tab> g:LspCleverSTab()
  snoremap <expr> <S-Tab> g:LspCleverSTab()

  # Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
  # See https://github.com/hrsh7th/vim-vsnip/pull/50
  nmap        s   <Plug>(vsnip-select-text)
  xmap        s   <Plug>(vsnip-select-text)
  nmap        S   <Plug>(vsnip-cut-text)
  xmap        S   <Plug>(vsnip-cut-text)
  # }}}

  # lsp {{{
  var lspServers = [
    {
      name: 'clangd',
      filetype: ['c', 'cpp'],
      path: '${pkgs.clang-tools}/bin/clangd',
      args: ['--background-index', '--clang-tidy'],
    },
    {
      name: 'cmake-language-server',
      filetype: ['cmake'],
      path: '${lib.getExe pkgs.cmake-language-server}',
      args: [],
    },
    {
      name: 'dockerls',
      filetype: ['dockerfile'],
      path: '${lib.getExe pkgs.nodePackages.dockerfile-language-server-nodejs}',
      args: ['--stdio'],
    },
    {
      name: 'jsonls',
      filetype: ['json', 'jsonc'],
      path: '${lib.getExe pkgs.nodePackages.vscode-json-languageserver}',
      args: ['--stdio'],
      features: {
        documentFormatting: v:true,
      },
      initializationOptions: {
        provideFormatter: v:true,
      },
    },
    {
      name: 'nil',
      filetype: ['nix'],
      path: '${lib.getExe pkgs.nil}',
      args: [],
    },
    {
      name: 'pyright',
      filetype: ['python'],
      path: '${pkgs.nodePackages.pyright}/bin/pyright-langserver',
      args: ['--stdio'],
    },
    {
      name: 'bashls',
      filetype: ['sh'],
      path: '${lib.getExe pkgs.nodePackages.bash-language-server}',
      args: ['start'],
    },
    {
      name: 'vimls',
      filetype: ['vim'],
      path: '${lib.getExe pkgs.nodePackages.vim-language-server}',
      args: ['--stdio'],
    },
    {
      name: 'yamlls',
      filetype: ['yaml', 'yaml.docker-compose'],
      path: '${lib.getExe pkgs.nodePackages.yaml-language-server}',
      args: ['--stdio'],
    },
    {
      name: 'efm',
      filetype: ['sh', 'c', 'cpp', 'gitcommit'],
      path: '${lib.getExe pkgs.efm-langserver}',
      args: [],
    },
  ]

  augroup lsp_servers
    autocmd VimEnter * call LspAddServer(lspServers)
  augroup END

  var lspOpts = {
    autoHighlightDiags: v:true,
    completionTextEdit: v:false,
    showDiagWithVirtualText: v:true,
    showInlayHints: v:true,
    snippetSupport: v:true,
    vsnipSupport: v:true,
    ultisnipsSupport: v:false,
  }

  autocmd VimEnter * call LspOptionsSet(lspOpts)
  # }}}
''
