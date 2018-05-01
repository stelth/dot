set hidden

if has('mac')
	let g:LanguageClient_serverCommands = {
				\ 'python': ['/usr/local/bin/pyls'],
				\ 'cpp': ['/usr/local/Cellar/llvm/6.0.0/bin/clangd'],
				\ 'c': ['/usr/local/Cellar/llvm/6.0.0/bin/clangd'],
				\ 'bash': ['/usr/local/bin/bash-language-server', 'start']
				\ }
else
	let g:LanguageClient_serverCommands = {
				\ 'python': ['/usr/local/bin/pyls'],
				\ 'cpp': ['/usr/lib/llvm-6.0/bin/clangd'],
				\ 'c': ['/usr/lib/llvm-6.0/bin/clangd']
				\ }
endif
