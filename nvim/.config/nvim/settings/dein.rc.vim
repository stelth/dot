" dein configuration

let g:dein#auto_recache = 1

let s:path = expand('$CACHE/dein')
if !dein#load_state(s:path)
	finish
endif

let s:dein_toml = '~/.config/nvim/settings/dein.toml'
let s:dein_lazy_toml = '~/.config/nvim/settings/deinlazy.toml'
let s:dein_ft_toml = '~/.config/nvim/settings/deinft.toml'

call dein#begin(s:path, [
      \ expand('<sfile>'), s:dein_toml, s:dein_lazy_toml, s:dein_ft_toml
      \ ])

call dein#load_toml(s:dein_toml, {'lazy': 0})
call dein#load_toml(s:dein_lazy_toml, {'lazy': 1})
call dein#load_toml(s:dein_ft_toml)

call dein#end()
call dein#save_state()

if !has('vim_starting') && dein#check_install()
  if dein#check_install()
    call dein#install()
  endif

  if dein#check_update()
    call dein#update()
  endif

  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
