nnoremap <F6> :UndotreeToggle<CR>

if has( "persistent_undo" )
	set undodir='~/.vim.local/.undodir/'
	set undofile
endif

let g:undotree_WindowLayout = 4
