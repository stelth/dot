au BufEnter * lua require'completion'.on_attach()
let g:completion_enable_snippet = 'Neosnippet'
let g:completion_auto_change_source = 1
let g:completion_chain_complete_list = {
			\ 'default' : {
			\   'default': [
			\       {'complete_items': ['lsp', 'path', 'snippet']},
			\       {'mode': '<c-p>'},
			\       {'mode': '<c-n>'}]
			\   }
			\}
