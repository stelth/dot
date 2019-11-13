" deoplate-clangx configuration

if has('unix')
	call deoplete#custom#var('clangx', 'clang_binary', '/usr/lib/llvm-9/bin/clang')
endif
