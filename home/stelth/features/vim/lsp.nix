{
  lib,
  pkgs,
}: ''
  vim9script

  # lsp {{{
  lsp#lsp#AddServer([{
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
    path: '${lib.getExe pkgs.nodePackages.vim-language-server}',
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
    path: '${lib.getExe pkgs.efm-langserver}',
    args: [],
    initializationOptions: {
      documentFormatting: v:true,
      completion: v:true,
    },
    debug: v:true,
  }])

  lsp#options#OptionsSet({
    autoComplete: v:true,
    autoHighlight: v:true,
    autoHighlightDiags: v:true,
    completionTextEdit: v:false,
    omniComplete: v:true,
    showDiagWithVirtualText: v:true,
    showInlayHints: v:true,
    snippetSupport: v:true,
    ultisnipsSupprt: v:false,
    useBufferCompletion: v:true,
    vsnipSupport: v:true,
  })

  def g:WhitespaceOnly(): bool
    return strpart(getline('.'), col('.') - 2, 1) =~ '^\s*$'
  enddef

  def g:LspCleverTab(): string
    return pumvisible() ? "\<C-n>" : vsnip#jumpable(1) ? "\<Plug>(vsnip-jump-next)" : g:WhitespaceOnly() ? "\<TAB>" : "\<C-n>"
  enddef

  def g:LspCleverSTab(): string
    return pumvisible() ? "\<C-p>" : vsnip#jumpable(-1) ? "\<Plug>(vsnip-jump-prev)" : g:WhitespaceOnly() ? "\<S-TAB>" : "\<C-p>"
  enddef

  inoremap <expr> <TAB> g:LspCleverTab()
  snoremap <expr> <TAB> g:LspCleverTab()
  inoremap <expr> <S-TAB> g:LspCleverSTab()
  snoremap <expr> <S-TAB> g:LspCleverSTab()

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

    highlight LspDiagVirtualTextError guifg='#f38ba8'
    highlight LspDiagVirtualTextHint guifg='#f9e2af'
    highlight LspDiagVirtualTextInfo guifg='#94e2d5'
    highlight LspDiagVirtualTextWarning guifg='#94e2d5'

    highlight LspDiagInlineError guifg='#f38ba8'
    highlight LspDiagInlineHint guifg='#f9e2af'
    highlight LspDiagInlineInfo guifg='#94e2d5'
    highlight LspDiagInlineWarning guifg='#94e2d5'
  enddef

  autocmd User LspAttached OnLspBufferAttached()
  # }}}
''
