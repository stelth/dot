{
  lib,
  pkgs,
  ...
}: ''
  vim9script

  set encoding=utf-8
  scriptencoding utf-8

  # => Vimrc 2.0
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

  set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
  set directory=$XDG_STATE_HOME/vim/swap | call mkdir(&directory, 'p', 0700)
  set undodir=$XDG_STATE_HOME/vim/undo | call mkdir(&undodir, 'p', 0700)
  set viewdir=$XDG_STATE_HOME/vim/view | call mkdir(&viewdir, 'p', 0700)

  # => Leader
  g:mapleader = ' '

  # => General Settings
  set clipboard^=unnamed,unnamedplus
  set cursorline
  set hlsearch
  set nowritebackup
  set signcolumn=yes
  set smartindent
  set termguicolors
  set updatetime=300

  colorscheme catppuccin_mocha

  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  nnoremap <Right> :bnext<CR>
  nnoremap <Left> :bprev<CR>

  nnoremap <BS> :noh<CR>

  # => lightline.vim
  g:lightline = { 'colorscheme': 'catppuccin_mocha' }

  # => lsp
  var lsp_servers = [{
    name: 'bashls',
    filetype: ['sh'],
    path: '${lib.getExe pkgs.nodePackages.bash-language-server}',
    args: ['start'],
  }, {
    name: 'clangd',
    filetype: ['c', 'cpp'],
    path: '${pkgs.clang-tools_17}/bin/clangd',
    args: ['--background-index'],
  }, {
    name: 'cmake-language-server',
    filetype: ['cmake'],
    path: '${lib.getExe pkgs.cmake-language-server}',
    args: [],
  }, {
    name: 'nil',
    filetype: ['nix'],
    path: '${lib.getExe pkgs.nil}',
    args: [],
    features: {
      documentFormatting: v:false,
    },
  }, {
    name: 'vscode-json-server',
    filetype: ['json'],
    path: '${lib.getExe pkgs.nodePackages.vscode-json-languageserver}',
    args: ['--stdio'],
  }, {
    name: 'marksman',
    filetype: ['markdown'],
    path: '${lib.getExe pkgs.marksman}',
    args: [],
  }, {
    name: 'pyright',
    filetype: ['python'],
    path: '${pkgs.nodePackages.pyright}/bin/pyright-langserver',
    args: ['--stdio'],
    workspaceConfig: {
      python: {
        pythonPath: '${lib.getExe pkgs.python3}',
      },
    },
  }, {
    name: 'vimls',
    filetype: ['vim'],
    path: '${pkgs.nodePackages.vim-language-server}/lib/node_modules/vim-language-server/bin/index.js',
    args: ['--stdio'],
  }, {
    name: 'yamlls',
    filetype: ['yaml', 'yaml.docker-compose'],
    path: '${lib.getExe pkgs.nodePackages.yaml-language-server}',
    args: ['--stdio'],
  }, {
    name: 'efm',
    filetype: [
      'sh',
      'cmake',
      'gitcommit',
      'json',
      'json5',
      'make',
      'nix',
      'python',
      'vim',
      'yaml',
    ],
    path: '${pkgs.efm-langserver}/bin/efm-langserver',
    args: [],
    initializationOptions: {
      documentFormatting: v:true,
      completion: v:true,
    },
    debug: v:true,
  }]
  autocmd User LspSetup call LspAddServer(lsp_servers)

  var lsp_options = {
    autoHighlight: true,
    autoHighlightDiags: true,
    completionMatcher: 'case',
    completionTextEdit: false,
    diagVirtualTextAlign: 'after',
    echoSignature: false,
    highlightDiagInline: true,
    showDiagWithVirtualText: true,
    showInlayHints: true,
    showSignature: true,
    useBufferCompletion: false,
  }
  autocmd User LspSetup call LspOptionsSet(lsp_options)

  g:should_format_on_save = v:true
  def g:ToggleFormat()
    g:should_format_on_save = !g:should_format_on_save
    if g:should_format_on_save
      echo "Autoformatting enabled"
    else
      echo "Autoformatting disabled"
    endif
  enddef

  def g:FormatBuffer()
    if g:should_format_on_save
      LspFormat
    endif
  enddef

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
    nmap <silent><buffer> <leader>tf :<C-u>call g:ToggleFormat()<CR>

    if &background == 'dark'
        highlight  LspDiagVirtualTextError    ctermbg=none  ctermfg=1
        highlight  LspDiagVirtualTextWarning  ctermbg=none  ctermfg=3
        highlight  LspDiagVirtualTextHint     ctermbg=none  ctermfg=2
        highlight  LspDiagVirtualTextInfo     ctermbg=none  ctermfg=5
    endif
    highlight  link  LspDiagSignErrorText    LspDiagVirtualTextError
    highlight  link  LspDiagSignWarningText  LspDiagVirtualTextWarning
    highlight  link  LspDiagSignHintText     LspDiagVirtualTextHint
    highlight  link  LspDiagSignInfoText     LspDiagVirtualTextInfo
    highlight LspDiagInlineError ctermfg=none cterm=undercurl
    highlight LspDiagInlineWarning ctermfg=none cterm=none
    highlight LspDiagInlineHint ctermfg=none cterm=none
    highlight LspDiagInlineInfo ctermfg=none cterm=none
    highlight LspDiagVirtualText ctermfg=1
    highlight LspDiagLine ctermbg=none

    augroup LspFormatting
      autocmd! * <buffer>
      au BufWritePost <buffer> call g:FormatBuffer()
    augroup END
  enddef
  autocmd User LspAttached OnLspBufferAttached()

  # => undotree
  g:undotree_ShortIndicators = 1
  g:undotree_WindowLayout = 4
  nnoremap <silent> <leader>u :UndotreeToggle<CR>

  # => vim-highlightedyank
  g:highlightedyank_highlight_duration = 300
''
