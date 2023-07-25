{
  pkgs,
  lib,
  ...
}: ''
    set encoding=utf-8
    scriptencoding utf-8

    " Vimrc 2.0 {{{
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

    set background=dark
    colorscheme nord

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

    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

    nnoremap <Right> :bnext<CR>
    nnoremap <Left> :bprev<CR>

    " airline {{{
    let g:airline#extensions#tabline#enabled=1
    let g:airline_powerline_fonts=1
    " }}}

    " asyncrun {{{
    let g:asyncrun_open=20
    " }}}

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

    " vim-vsnip {{{
    imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
    smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

    " Expand or jump
    imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
    smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

    function! g:WhitespaceOnly()
      return strpart(getline('.'), col('.') - 2, 1) =~ '^\s*$'
    endfunction

    function! g:LspCleverTab()
      return pumvisible() ? "\<c-n>" : vsnip#jumpable(1) ? "\<Plug>(vsnip-jump-next)" : g:WhitespaceOnly() ? "\<tab>" : "\<c-n>"
    endfunction

    function! g:LspCleverSTab()
      return pumvisible() ? "\<c-p>" : vsnip#jumpable(-1) ? "\<Plug>(vsnip-jump-prev)" : g:WhitespaceOnly() ? "\<s-tab>" : "\<c-p>"
    endfunction

    " Jump forward or backward
    inoremap <expr> <Tab> g:LspCleverTab()
    snoremap <expr> <Tab> g:LspCleverTab()
    inoremap <expr> <S-Tab> g:LspCleverSTab()
    snoremap <expr> <S-Tab> g:LspCleverSTab()

    " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
    " See https://github.com/hrsh7th/vim-vsnip/pull/50
    nmap        s   <Plug>(vsnip-select-text)
    xmap        s   <Plug>(vsnip-select-text)
    nmap        S   <Plug>(vsnip-cut-text)
    xmap        S   <Plug>(vsnip-cut-text)
    " }}}

    " lsp {{{
    call lsp#lsp#AddServer([{
  \     'name': 'clangd',
  \     'filetype': ['c', 'cpp'],
  \     'path': '${pkgs.clang-tools_16}/bin/clangd',
  \     'args': ['--background-index', '--clang-tidy'],
  \   }, {
  \     'name': 'cmake-language-server',
  \     'filetype': 'cmake',
  \     'path': '${lib.getExe pkgs.cmake-language-server}',
  \     'args': [],
  \   }, {
  \     'name': 'dockerls',
  \     'filetype': 'dockerfile',
  \     'path': '${lib.getExe pkgs.nodePackages.dockerfile-language-server-nodejs}',
  \     'args': ['--stdio'],
  \   }, {
  \     'name': 'jsonls',
  \     'filetype': [
  \       'json',
  \       'jsonc'
  \     ],
  \     'path': '${lib.getExe pkgs.nodePackages.vscode-json-languageserver}',
  \     'args': ['--stdio'],
  \     'features': {
  \       'documentFormatting': v:true,
  \     },
  \     'initializationOptions': {
  \       'provideFormatter': v:true,
  \     },
  \   }, {
  \     'name': 'marksman',
  \     'filetype': 'markdown',
  \     'path': '${lib.getExe pkgs.marksman}',
  \     'args': [],
  \   }, {
  \     'name': 'nil',
  \     'filetype': 'nix',
  \     'path': '${lib.getExe pkgs.nil}',
  \     'args': [],
  \     'features': {
  \       'documentFormatting': v:false,
  \     },
  \   }, {
  \     'name': 'pyright',
  \     'filetype': 'python',
  \     'path': '${pkgs.nodePackages.pyright}/bin/pyright-langserver',
  \     'args': ['--stdio'],
  \   }, {
  \     'name': 'bashls',
  \     'filetype': 'sh',
  \     'path': '${lib.getExe pkgs.nodePackages.bash-language-server}',
  \     'args': ['start'],
  \   }, {
  \     'name': 'vimls',
  \     'filetype': 'vim',
  \     'path': '${lib.getExe pkgs.nodePackages.vim-language-server}',
  \     'args': ['--stdio'],
  \   }, {
  \     'name': 'yamlls',
  \     'filetype': [
  \       'yaml',
  \       'yaml.docker-compose'
  \     ],
  \     'path': '${lib.getExe pkgs.nodePackages.yaml-language-server}',
  \     'args': ['--stdio'],
  \   }, {
  \     'name': 'efm',
  \     'filetype': [
  \       'sh',
  \       'c',
  \       'cpp',
  \       'dockerfile',
  \       'gitcommit',
  \       'java',
  \       'json',
  \       'json5',
  \       'make',
  \       'markdown',
  \       'nix',
  \       'python',
  \       'vim',
  \       'yaml',
  \     ],
  \     'path': '${lib.getExe pkgs.efm-langserver}',
  \     'args': [],
  \     'initializationOptions': {
  \       'documentFormatting': v:true,
  \     },
  \   }])

    call lsp#options#OptionsSet({
  \     'autoHighlightDiags': v:true,
  \     'completionTextEdit': v:false,
  \     'showDiagWithVirtualText': v:true,
  \     'showInlayHints': v:true,
  \     'snippetSupport': v:true,
  \     'vsnipSupport': v:true,
  \     'ultisnipsSupport': v:false,
  \     'useBufferCompletion': v:true,
  \   })

    def OnLspBufferAttached()
      nmap <buffer> <leader>cf :LspFormat<CR>
      vmap <buffer> <leader>cf :LspFormat<CR>
      nmap <buffer> <leader>ca :LspCodeAction<CR>
      vmap <buffer> <leader>ca :LspCodeAction<CR>
      nmap <buffer> <leader>cr :LspRename<CR>
      nmap <buffer> <leader>gp :LspPeekDefinition<CR>
      nmap <buffer> <leader>gd :LspGotoDefinition<CR>
      nmap <buffer> <leader>wa :LspWorkspaceAddFolder<CR>
      nmap <buffer> <leader>wr :LspWorkspaceRemoveFolder<CR>
      nmap <buffer> <leader>wl :LspWorkspaceListFolders<CR>
      nmap <buffer> <leader>gi :LspGotoImpl<CR>
      nmap <buffer> <leader>gT :LspGotoTypeDefinition<CR>
      nmap <buffer> <leader>gt :LspPeekTypeDefinition<CR>
      nmap <buffer> <leader>sl :LspDiagCurrent<CR>
      nmap <buffer> <leader>sb :LspDiagFirst<CR>
      nmap <buffer> <leader>sc :LspDiagHere<CR>
      nmap <buffer> <leader>[g :LspDiagPrev<CR>
      nmap <buffer> <leader>]g :LspDiagNext<CR>
      nmap <buffer> <leader>[d :LspDiagLast<CR>
      nmap <buffer> <leader>]d :LspDiagFirst<CR>
      nmap <buffer> <leader>q :LspDiagShow<CR>
      nmap <buffer> K :LspHover<CR>
      nmap <buffer> <leader>o :LspOutline<CR>
      nmap <buffer> <leader>ci :LspIncomingCalls<CR>
      nmap <buffer> <leader>co :LspOutgoingCalls<CR>
    enddef

    augroup lsp_install
      au!
      autocmd User LspAttached call OnLspBufferAttached()
    augroup END
    " }}}
''
