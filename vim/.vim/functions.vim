" Custom Functions

"clean trailing whitespace on save
function! DeleteTrailingWhitespace( )
	let l = line( "." )
	let c = col( "." )
	%s/\s\+$//e
	call cursor( l, c )
endfunction

function! MyFoldText( )
	let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{{\d*\s*', '', 'g') . ' '
	let lines_count = v:foldend - v:foldstart + 1
	let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
	let foldchar = '·'
	let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	let foldtextend = lines_count_text . repeat(foldchar, 8)
	let length = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g'))
	return foldtextstart . repeat(foldchar, winwidth(0)-length) . foldtextend
endfunction

function! s:ToggleFold( )
	if &foldmethod == 'marker'
		let &l:foldmethod = 'syntax'
	else
		let &l:foldmethod = 'marker'
	endif
	echo 'foldmethod is now ' . &l:foldmethod
endfunction
