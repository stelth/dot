" Settings for vim-clang-format

if executable('clang-format')
	let g:clang_format#command = 'clang-format'
elseif executable('clang-format-6.0')
	let g:clang_format#command = 'clang-format-6.0'
endif

let g:clang_format#detect_style_file = 1

autocmd FileType c,cpp,objc nnoremap <buffer>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer>cf :ClangFormat<CR>
