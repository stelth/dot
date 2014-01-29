""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jason Cox's .vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => General {{{

" => Vim Generic Settings {{{
" Sets how many lines VIM has to remember

" }}}

let s:vim_home = '~/.vim/'

let config_list = [
	\ 'base.vim',
	\ 'plugins.vim',
	\ 'functions.vim',
	\ 'theme.vim',
	\ 'settings.vim',
	\ 'leader.vim',
	\ 'keymappings.vim',
\ ]

for files in config_list
	for f in split( glob( s:vim_home.files), '\n' )
		exec 'source '.f
	endfor
endfor

nnoremap <silent> <F5> :%!astyle<CR>


" }}}

" => Command Mode Related {{{


" }}}

" => Protobuf Section {{{
augroup filetype
	au! BufRead,BufNewFile *.proto setfiletype proto
augroup END
" }}}

" => Plugins {{{

" => unite.vim {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#set_profile('files', 'smartcase', 1)

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

nnoremap <silent> [unite]<space> :<C-u>Unite -resume -auto-resize -buffer-name=mixed file_rec/async buffer file_mru bookmark<cr>
nmap <silent> <C-p> [unite]<space>
nnoremap <silent> [unite]f :<C-u>Unite -resume -auto-resize -buffer-name=files file_rec<cr>
nnoremap <silent> [unite]r :<C-u>Unite -auto-resize -buffer-name=mru -start-insert file_mru<cr>
nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]/ :<C-u>Unite -auto-resize -buffer-name=search grep:.<cr>
nnoremap <silent> [unite]o :<C-u>Unite -auto-resize -buffer-name=outline outline<cr>
nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>
nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=tags tag<cr>
" }}}

" => Gundo {{{
let g:gundo_width = 60
let g:gundo_preview_height = 40
let g:gundo_right = 1
nnoremap <F6> :GundoToggle<CR>
" }}}

" => Vimux {{{
map <leader>rp :VimuxPromptCommand<CR>
map <leader>rl :VimuxRunLastCommand<CR>
map <leader>ri :VimuxInspectRunner<CR>
map <leader>rx :VimuxClosePanes<CR>
map <leader>rs :VimuxInterruptRunner<CR>
" }}}

" => clang_complete {{{
let g:clang_auto_select = 0
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1
let g:clang_complete_hl_errors = 1
let g:clang_close_preview = 1
let g:clang_use_library = 1
let g:clang_library_path = '/usr/lib64'
let g:clang_snippets = 1
let g:clang_snippets_engine = 'ultisnips'
let g:clang_complete_macros = 1
let g:clang_complete_patterns = 1
" }}}

" => CScope Macros {{{

" }}}

" => neocomplcache {{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_dictionary_filetype_lists = {
			\ 'default' : '',
			\ 'vimshell' : $HOME.'/.vimshell_hist',
			\ 'scheme' : $HOME.'/.gosh_completions'
			\ }

if !exists( 'g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns[ 'default' ] = '\h\w'

inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()


if !exists( 'g:neocomplcache_force_omni_patterns' )
	let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" }}}

" => UltiSnips {{{
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
" }}}

" => NerdCommenter {{{

" }}}

" => glsl.vim {{{
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl set filetype=glsl

" }}}

" => vim-airline {{{
let g:airline_theme='base16'
let g:airline_powerline_fonts=1
let g:airline_enable_branch=1
set noshowmode
" }}}
"
" => vim-autotags {{{
let g:autotags_no_global = 1
let g:autotagsdir=$HOME."/.tags"
" }}}
