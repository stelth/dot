" Settings for deoplete-jedi

if has('mac')
	let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3'
else
	let g:deoplete#sources#jedi#python_path = '/usr/bin/python3'
endif
