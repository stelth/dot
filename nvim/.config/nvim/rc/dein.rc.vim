" dein configurations.

let g:dein#install_github_api_token = '8424ba907c6b2d5c7a240af92a1561cd14cd2cb7'

let g:dein#auto_recache = v:true
let g:dein#lazy_rplugins = v:true
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = v:true

let g:dein#inline_vimrcs = ['options.rc.vim', 'mappings.rc.vim']
if has('nvim')
  call add(g:dein#inline_vimrcs, 'neovim.rc.vim')
elseif has('gui_running')
  call add(g:dein#inline_vimrcs, 'gui.rc.vim')
endif
if IsWindows()
  call add(g:dein#inline_vimrcs, 'windows.rc.vim')
else
  call add(g:dein#inline_vimrcs, 'unix.rc.vim')
endif
call map(g:dein#inline_vimrcs, "resolve(expand('~/.config/nvim/rc/' . v:val))")

let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
  finish
endif

let s:dein_toml = '~/.config/nvim/rc/dein.toml'
let s:dein_lazy_toml = '~/.config/nvim/rc/deinlazy.toml'
let s:dein_ft_toml = '~/.config/nvim/rc/deinft.toml'

call dein#begin(s:path, [
      \ expand('<sfile>'), s:dein_toml, s:dein_lazy_toml, s:dein_ft_toml
      \ ])

call dein#load_toml(s:dein_toml, {'lazy': 0})
call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
call dein#load_toml(s:dein_ft_toml)

let s:vimrc_local = findfile('vimrc_local.vim', getcwd())
if s:vimrc_local !=# ''
  " Load develop version plugins.
  call dein#local(fnamemodify(s:vimrc_local, ':h'),
        \ {'frozen': 1, 'merged': 0},
        \ ['vim*', 'nvim-*', 'unite-*', 'neco-*', '*.vim', 'denite.nvim'])
  call dein#local(fnamemodify(s:vimrc_local, ':h'),
        \ {'frozen': 1, 'merged': 0},
        \ ['deoplete-*', '*.nvim'])
endif

call dein#end()
call dein#save_state()

if !has('vim_starting')
  " Installation check.
  if dein#check_install()
    call dein#install()
  endif

  " Update check
  if dein#check_update()
    call dein#update()
  endif

  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
