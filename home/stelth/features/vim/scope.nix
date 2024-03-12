{...}: ''
  vim9script

  import autoload 'scope/fuzzy.vim'

  nnoremap <leader>f <scriptcmd>fuzzy.File('fd -tf --follow', 100000)<CR>
  nnoremap <leader>/ <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case')<CR>
  nnoremap <leader>, <scriptcmd>fuzzy.Buffer()<CR>
  nnoremap <leader>: <scriptcmd>fuzzy.CmdHistory()<CR>

  nnoremap <leader>sb <scriptcmd>fuzzy.BufSearch()<CR>
  nnoremap <leader>sw <scriptcmd>fuzzy.Grep('rg --vimgrep --no-heading --smart-case ' . expand('<cword>'))<CR>

  nnoremap <leader>hc <scriptcmd>fuzzy.Command()<CR>
  nnoremap <leader>ht <scriptcmd>fuzzy.Help()<CR>
  nnoremap <leader>hm <scriptcmd>fuzzy.Keymap()<CR>
''
