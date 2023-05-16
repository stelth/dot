{
  config,
  pkgs,
  ...
}: let
  color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
in ''
  " Vimrc 2.0 {{{

  if empty($MYVIMRC) | let $MYVIMRC = expand('<sfile>:p') | endif

  if empty($XDG_CACHE_HOME)  | let $XDG_CACHE_HOME  = $HOME.'/.cache'       | endif
  if empty($XDG_CONFIG_HOME) | let $XDG_CONFIG_HOME = $HOME.'/.config'      | endif
  if empty($XDG_DATA_HOME)   | let $XDG_DATA_HOME   = $HOME.'/.local/share' | endif
  if empty($XDG_STATE_HOME)  | let $XDG_STATE_HOME  = $HOME.'/.local/state' | endif

  set runtimepath^=$XDG_CONFIG_HOME/vim
  set runtimepath+=$XDG_DATA_HOME/vim
  set runtimepath+=$XDG_CONFIG_HOME/vim/after

  set packpath^=$XDG_DATA_HOME/vim,$XDG_CONFIG_HOME/vim
  set packpath+=$XDG_CONFIG_HOME/vim/after,$XDG_DATA_HOME/vim/after

  let g:netrw_home = $XDG_DATA_HOME.'/vim'
  call mkdir($XDG_DATA_HOME.'/vim/spell', 'p', 0700)

  set backupdir=$XDG_STATE_HOME/vim/backup | call mkdir(&backupdir, 'p', 0700)
  set directory=$XDG_STATE_HOME/vim/swap   | call mkdir(&directory, 'p', 0700)
  set undodir=$XDG_STATE_HOME/vim/undo     | call mkdir(&undodir,   'p', 0700)
  set viewdir=$XDG_STATE_HOME/vim/view     | call mkdir(&viewdir,   'p', 0700)
  " }}}

  " => Leader
  let mapleader = ' '

  " => General Settings
  set clipboard^=unnamed,unnamedplus
  set cursorline
  set hlsearch
  set ignorecase
  set mouse=a
  set nowritebackup
  set number
  set relativenumber
  set signcolumn=yes
  set smartcase
  set smartindent
  set termguicolors
  set undofile
  set updatetime=300

  packadd termdebug

  source ${color}

  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

  " fzf-vim {{{
  nmap <leader>hc :Commands<CR>
  nmap <leader>ht :Helptags<CR>
  nmap <leader>hm :Maps<CR>
  nmap <leader>hf :Filetypes<CR>

  nmap <leader>sg :Rg<CR>
  nmap <leader>sb :BLines<CR>
  nmap <leader>sh :History:<CR>
  nmap <leader>sm :Marks<CR>
  nmap <leader>sw :execute 'Rg ' . expand('<cword>')<CR>
  nmap <leader>ff :Files<CR>

  nmap <leader>, :Buffers<CR>
  nmap <leader>/ :Rg<CR>
  nmap <leader>: :History:<CR>

  nmap <leader>gc :Commits<CR>
  nmap <leader>gcc :BCommits<CR>
  nmap <leader>gs :GFiles?<CR>
  " }}}

  " undotree {{{
  let g:undotree_ShortIndicators=1
  let g:undotree_WindowLayout=4
  nnoremap <silent> <leader>u :UndotreeToggle<CR>
  " }}}

  " vim-cmake {{{
  let g:cmake_link_compile_commands = 1
  " }}}

  " ale {{{
  let g:ale_disable_lsp = 1
  " }}}

  " coc-nvim {{{
  let g:coc_config_home=$XDG_CONFIG_HOME.'/vim'

  " Use tab for trigger completion with characters ahead and navigate
  inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump', \'\'])\<CR>" :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
  inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

  " Make <CR> to accept selected completion item or notify coc.nvim to format
  " <C-g>u breaks current undo, please make your own choice
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'

  inoremap <silent><expr> <c-@> coc#refresh()

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call ShowDocumentation()<CR>

  function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
  call CocActionAsync('doHover')
  else
  call feedkeys('K', 'in')
  endif
  endfunction

  " Highlight the symbol and its references when holding the cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying code actions to the selected code block
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying code actions at the cursor position
  nmap <leader>ac  <Plug>(coc-codeaction-cursor)
  " Remap keys for apply code actions affect whole buffer
  nmap <leader>as  <Plug>(coc-codeaction-source)
  " Apply the most preferred quickfix action to fix diagnostic on the current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Remap keys for applying refactor code actions
  nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
  xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
  nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

  nmap <silent> <leader>cf :call CocAction('format')<CR>

  " Run the Code Lens action on the current line
  nmap <leader>cl  <Plug>(coc-codelens-action)

  " Map function and class text objects
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

  " Use CTRL-S for selections ranges
  " Requires 'textDocument/selectionRange' support of language server
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Mappings for CoCList
  " Show all diagnostics
  nnoremap <silent><nowait> <space>la  :<C-u>CocList diagnostics<cr>
  " Manage extensions
  nnoremap <silent><nowait> <space>le  :<C-u>CocList extensions<cr>
  " Show commands
  nnoremap <silent><nowait> <space>lc  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent><nowait> <space>lo  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent><nowait> <space>ls  :<C-u>CocList -I symbols<cr>
  " Do default action for next item
  nnoremap <silent><nowait> <space>lj  :<C-u>CocNext<CR>
  " Do default action for previous item
  nnoremap <silent><nowait> <space>lk  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent><nowait> <space>lp  :<C-u>CocListResume<CR>
  " }}}
''
