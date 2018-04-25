set hidden

if has('mac')
	let g:LanguageClient_serverCommands = {
				\ 'python': ['/usr/local/bin/pyls'],
				\ 'cpp': ['/usr/local/Cellar/llvm/6.0.0/bin/clangd']
				\ }
endif
