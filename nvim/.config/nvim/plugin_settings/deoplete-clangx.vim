" deoplate-clangx configuration

if has('unix')
	call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang-9')
endif
