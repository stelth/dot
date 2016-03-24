if exists("g:ctrlp_user_command")
	unlet g:ctrlp_user_command
endif

if executable('ag')
	let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
	let g:ctrlp_use_caching = 0
else
	let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
	let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

let g:ctrlp_by_filename = 1
let g:ctrlp_switch_buffer = 0
let g:ctrlp_cmd = 'CtrlPBuffer'
