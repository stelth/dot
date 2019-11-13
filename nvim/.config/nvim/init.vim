let s:nvim_home = '~/.config/nvim/'

for filename in sort( split( glob( s:nvim_home . 'settings/*.vim'), '\n' ) )
	execute 'source '.filename
endfor

for filename in sort( split( glob( s:nvim_home . '/plugin_settings/*.vim'), '\n' ) )
	execute 'source '.filename
endfor
