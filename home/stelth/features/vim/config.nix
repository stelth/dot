{
  config,
  lib,
  pkgs,
  ...
}: let
  color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
in ''
  " Vimrc 2.0 {{{

  if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

  if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME.'/.cache'       | endif
  if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME.'/.config'      | endif
  if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME.'/.local/share' | endif
  if empty($XDG_STATE_HOME)  | let $XDG_STATE_HOME  = $HOME.'/.local/state' | endif

  set runtimepath^=$XDG_CONFIG_HOME/vim
  set runtimepath+=$XDG_DATA_HOME/vim
  set runtimepath+=$XDG_CONFIG_HOME/vim/after

  set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
  set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

  let g:netrw_home = $XDG_DATA_HOME.'/vim'
  call mkdir($XDG_DATA_HOME.'/vim/spell', 'p', 0700)

  set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
  set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p', 0700)
  set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p', 0700)
  set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p', 0700)
  " }}}

  " => Leader
  let mapleader = ' '

  " => General Settings
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

  " fzf-vim {{{
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
  " }}}

  " undotree {{{
  let g:undotree_ShortIndicators=1
  let g:undotree_WindowLayout=4
  nnoremap <silent> <leader>u :UndotreeToggle<CR>
  " }}}

  " vim-cmake {{{
  let g:cmake_link_compile_commands = 1
  " }}}

  " asyncomplete.vim {{{
  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

  au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

  imap <expr> <Tab>
    \ pumvisible() ? "\<C-n>" :
    \ vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' :
    \ '<Tab>'
  smap <expr> <Tab> vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>'

  imap <expr> <S-Tab>
    \ pumvisible() ? "\<C-p>" :
    \ vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' :
    \ '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'

  inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"
  " }}}

  " ale {{{
  let g:ale_disable_lsp = 1
  let g:ale_fixers = {
  \ 'c': ['clang-format'],
  \ 'cmake': ['cmake-format'],
  \ 'cpp': ['clang-format'],
  \ 'dockerfile': ['dprint'],
  \ 'java': ['google-java-format'],
  \ 'json': ['fixjson'],
  \ 'markdown': ['prettier'],
  \ 'nix': ['alejandra', 'statix'],
  \ 'python': ['black', 'isort'],
  \ 'sh': ['shfmt'],
  \ 'yaml': ['prettier'],
  \}
  let g:ale_linters = {
  \ 'c': ['cpplint', 'clangtidy'],
  \ 'cmake': ['cmake-lint'],
  \ 'cpp': ['cpplint', 'clangtidy'],
  \ 'dockerfile': ['hadolint'],
  \ 'git': ['gitlint'],
  \ 'markdown': ['vale', 'write-good'],
  \ 'python': ['flake8', 'pylint'],
  \ 'sh': ['shellcheck'],
  \ 'vim': ['vint'],
  \ 'yaml': ['yamllint'],
  \}
  " }}}

  " vim-lsp {{{
  let g:lsp_settings_enable_suggestions = 0

  autocmd User lsp_setup call lsp#register_server({
  \   'name': 'nil',
  \   'cmd': {server_info->['nil']},
  \   'whitelist': ['nix'],
  \})

  let g:lsp_settings = {
  \   'bash-language-server': {
  \     'cmd': [
  \       '${lib.getExe pkgs.nodePackages.bash-language-server}',
  \       'start',
  \     ],
  \   },
  \   'clangd': {
  \     'cmd': [
  \       '${pkgs.clang-tools}/bin/clangd',
  \     ],
  \   },
  \   'cmake-language-server': {
  \     'cmd': [
  \       '${lib.getExe pkgs.cmake-language-server}',
  \     ],
  \   },
  \   'docker-langserver': {
  \     'cmd': [
  \       '${lib.getExe pkgs.nodePackages.dockerfile-language-server-nodejs}',
  \       '--stdio',
  \     ],
  \   },
  \   'json-languageserver': {
  \     'cmd': [
  \       '${lib.getExe pkgs.nodePackages.vscode-json-languageserver}',
  \       '--stdio',
  \     ],
  \   },
  \   'marksman': {
  \     'cmd': [
  \       '${lib.getExe pkgs.marksman}',
  \       'server',
  \     ],
  \   },
  \   'nil': {
  \     'cmd': [
  \       '${lib.getExe pkgs.nil}',
  \     ],
  \   },
  \   'pyright-langserver': {
  \     'cmd': [
  \       '${pkgs.nodePackages.pyright}/bin/pyright-langserver',
  \       '--stdio',
  \     ],
  \   },
  \   'vim-language-server': {
  \     'cmd': [
  \       '${lib.getExe pkgs.nodePackages.vim-language-server}',
  \       '--stdio',
  \     ],
  \   },
  \   'yaml-language-server': {
  \     'cmd': [
  \       '${lib.getExe pkgs.nodePackages.yaml-language-server}',
  \       '--stdio',
  \     ],
  \   },
  \}
  " }}}
''
