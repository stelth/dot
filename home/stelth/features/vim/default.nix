{
  config,
  pkgs,
  ...
}: let
  color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
in {
  imports = [
    ./dev.nix
    ./lsp.nix
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
    packageConfigurable = pkgs.vim-full.override {
      guiSupport = "no";
      darwinSupport = pkgs.stdenvNoCC.isDarwin;
    };
    extraConfig = ''
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
    '';

    plugins = with pkgs.vimExtraPlugins; [
      auto-pairs
      fzf-vim
      is-vim
      markdown-preview-nvim
      undotree
      vim-dispatch
      vim-eunuch
      vim-flagship
      vim-fugitive
      vim-manpager
      vim-pager
      vim-repeat
      vim-sensible
      vim-signify
      vim-sleuth
      vim-speeddating
      vim-surround
      vim-system-copy
      vim-tmux-navigator
      vim-unimpaired
      vim-vinegar
    ];
  };
}
