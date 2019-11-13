"Ddeoplete configuration

let g:deoplete#enable_at_startup = 1

imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

if has('conceal')
	set conceallevel=2
	set concealcursor=niv
endif
