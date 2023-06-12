{
  config,
  pkgs,
  lib,
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

  " vim-vsnip {{{
  imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
  smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

  " Expand or jump
  imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
  smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

  " Jump forward or backward
  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

  " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
  " See https://github.com/hrsh7th/vim-vsnip/pull/50
  nmap        s   <Plug>(vsnip-select-text)
  xmap        s   <Plug>(vsnip-select-text)
  nmap        S   <Plug>(vsnip-cut-text)
  xmap        S   <Plug>(vsnip-cut-text)
  " }}}

  " lsp {{{
  let lspServers = [
                  \ {
                  \   'name': 'clangd',
                  \   'filetype': ['c', 'cpp'],
                  \   'path': '${pkgs.clang-tools}/bin/clangd',
                  \   'args': ['--background-index', '--clang-tidy'],
                  \ },
                  \ {
                  \   'name': 'cmake-language-server',
                  \   'filetype': ['cmake'],
                  \   'path': '${lib.getExe pkgs.cmake-language-server}',
                  \   'args': [],
                  \ },
                  \ {
                  \   'name': 'dockerls',
                  \   'filetype': ['dockerfile'],
                  \   'path': '${lib.getExe pkgs.nodePackages.dockerfile-language-server-nodejs}',
                  \   'args': ['--stdio'],
                  \ },
                  \ {
                  \   'name': 'jsonls',
                  \   'filetype': ['json', 'jsonc'],
                  \   'path': '${lib.getExe pkgs.nodePackages.vscode-json-languageserver}',
                  \   'args': ['--stdio'],
                  \   'features': {
                  \     'documentFormatting': v:true,
                  \   },
                  \   'initializationOptions': {
                  \     'provideFormatter': v:true,
                  \   },
                  \ },
                  \ {
                  \   'name': 'nil',
                  \   'filetype': ['nix'],
                  \   'path': '${lib.getExe pkgs.nil}',
                  \   'args': [],
                  \ },
                  \ {
                  \   'name': 'pyright',
                  \   'filetype': ['python'],
                  \   'path': '${pkgs.nodePackages.pyright}/bin/pyright-langserver',
                  \   'args': ['--stdio'],
                  \ },
                  \ {
                  \   'name': 'bashls',
                  \   'filetype': ['sh'],
                  \   'path': '${lib.getExe pkgs.nodePackages.bash-language-server}',
                  \   'args': ['start'],
                  \ },
                  \ {
                  \   'name': 'vimls',
                  \   'filetype': ['vim'],
                  \   'path': '${lib.getExe pkgs.nodePackages.vim-language-server}',
                  \   'args': ['--stdio'],
                  \ },
                  \ {
                  \   'name': 'yamlls',
                  \   'filetype': ['yaml', 'yaml.docker-compose'],
                  \   'path': '${lib.getExe pkgs.nodePackages.yaml-language-server}',
                  \   'args': ['--stdio'],
                  \ },
                  \ ]
  augroup lsp_servers
    autocmd VimEnter * call LspAddServer(lspServers)
  augroup END

  let lspOpts = #{
                \ autoHighlightDiags: v:true,
                \ showDiagWithVirtualText: v:true,
                \ showInlayHints: v:true,
                \ }
  autocmd VimEnter * call LspOptionsSet(lspOpts)
  " }}}
''
