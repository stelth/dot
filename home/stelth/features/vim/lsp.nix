{pkgs, ...}: {
  home.packages = with pkgs;
    [
      nodejs

      # Bash
      shellcheck
      shfmt

      #C/CPP
      clang-tools
      cpplint

      # CMake
      cmake-format

      # Docker
      hadolint

      # Git
      gitlint

      # Java
      google-java-format

      # JSON
      nodePackages.fixjson

      # Markdown
      nodePackages.prettier
      vale
      nodePackages.write-good

      # Nix
      alejandra
      statix

      # Python
      (python3.withPackages
        (ps: with ps; [black flake8 isort pylint]))

      # Vim
      vim-vint

      # YAML
      yamllint
    ]
    ++ lib.optionals (!pkgs.stdenvNoCC.isDarwin) [checkmake];

  programs.vim = {
    plugins = with pkgs.vimExtraPlugins; [
      coc-clangd
      coc-cmake
      coc-diagnostic
      coc-docker
      coc-git
      coc-json
      coc-lists
      coc-markdownlint
      coc-nvim
      coc-prettier
      coc-pyright
      coc-sh
      coc-snippets
      coc-vimlsp
      coc-yaml
    ];

    extraConfig = ''
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
    '';
  };
}
