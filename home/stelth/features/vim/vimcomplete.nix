{...}: ''
  vim9script

  g:vimcomplete_tab_enable = 1
  g:vimcomplete_noname_buf_enable = v:true

  var vimcomplete_options = {
    completor: { shuffleEqualPriority: v:true },
    buffer: { enable: v:true, urlComplete: true, envComplete: true },
    lsp: { enable: v:true },
    vsnip: { enable: v:true },
  }
  g:VimCompleteOptionsSet(vimcomplete_options)
''
