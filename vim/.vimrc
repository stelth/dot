let s:vim_home = '~/.vim/'

for filename in sort( split( glob( '~/.vim/*.vim'), '\n' ) )
	execute 'source '.filename
endfor

for filename in sort( split( glob( '~/.vim/plugin_settings/*.vim'), '\n' ) )
	execute 'source '.filename
endfor

set shell=/bin/bash\ -i
