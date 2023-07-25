{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dev.nix
    ./lsp.nix
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
    extraConfig = import ./config.nix {inherit lib pkgs;};
    plugins = with pkgs.vimPlugins;
      [
        asyncrun-vim
        asynctasks-vim
        auto-pairs
        autosuggest-vim
        fzf-vim
        is-vim
        markdown-preview-nvim
        nord-vim
        undotree
        vim-airline
        vim-dispatch
        vim-eunuch
        vim-fugitive
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
