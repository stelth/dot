" Unite.vim settings

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#set_profile('files', 'context.smartcase', 1)

let g:unite_data_directory='~/.vim.local/cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_file_rec_max_cache_files=5000
let g:unite_prompt='>> '

let g:unite_source_grep_command='ag'
let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden'
let g:unite_source_grep_recursive_opts=''

function! s:unite_settings()
	nmap <buffer> Q <plug>(unite_exit)
	nmap <buffer> <esc> <plug>(unite_exit)
	imap <buffer> <esc> <plug>(unite_exit)
endfunction
autocmd FileType unite call s:unite_settings()

nnoremap [unite] <nop>
nmap <space> [unite]

nnoremap <silent> [unite]<space> :<C-u>Unite -no-split  -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr>
nnoremap <silent> [unite]f :<C-u>Unite -no-split -buffer-name=files file_rec<cr>
nnoremap <silent> [unite]r :<C-u>Unite -no-split -buffer-name=mru -start-insert file_mru<cr>
nnoremap <silent> [unite]y :<C-u>Unite -no-split -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -no-split -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -no-split -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -no-split -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]o :<C-u>Unite -no-split -buffer-name=outline outline<cr>
nnoremap <silent> [unite]s :<C-u>Unite -no-split -quick-match buffer<cr>
