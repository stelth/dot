imap <C-n> <Plug>(neosnippet_expand_or_jump)
smap <C-n> <Plug>(neosnippet_expand_or_jump)
xmap <C-n> <Plug>(neosnippet_expand_target)

smap <expr><TAB> :neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
