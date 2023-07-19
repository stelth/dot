{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dev.nix
    ./lsp.nix
  ];

  home.persistence = {
    "/persist/home/stelth".directories = [".config/coc"];
  };

  xdg.configFile."vim/vimrc".text = import ./config.nix {
    inherit config lib pkgs;
  };

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      source ~/.config/vim/vimrc
    '';
    plugins = with pkgs.vimPlugins;
      [
        asyncrun-vim
        asynctasks-vim
        auto-pairs
        fzf-vim
        is-vim
        markdown-preview-nvim
        nord-vim
        search-complete-vim
        undotree
        vim-airline
        vim-dispatch
        vim-eunuch
        vim-fugitive
        vim-manpager
        vim-markdown-toc
        vim-orgmode
        vim-pager
        vim-repeat
        vim-sensible
        vim-signify
        vim-sleuth
        vim-speeddating
        vim-surround
        vim-tmux-navigator
        vim-unimpaired
        vim-vinegar
      ]
      ++ lib.optionals pkgs.stdenvNoCC.isLinux [vim-wayland-clipboard];
  };
}
