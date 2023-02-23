{
  self,
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # C/C++
    clang-tools
    cppcheck
    cpplint
    include-what-you-use
    lldb

    #nix
    alejandra
    deadnix
    rnix-lsp
    statix

    # python
    (python3.withPackages
      (ps: with ps; [black debugpy flake8 isort yamllint pylint]))

    # Lua
    stylua

    # Docker
    hadolint

    # Shell scripting
    shellcheck
    shellharden
    shfmt

    # {C}Make
    checkmake
    cmake-format

    # Additional
    actionlint
    gitlint
    marksman
    nodePackages.jsonlint
    proselint
    taplo
  ];

  programs.vim = {
    plugins = with pkgs.vimExtraPlugins; [
      ale
      coc-clangd
      coc-cmake
      coc-docker
      coc-git
      coc-java
      coc-json
      coc-lists
      coc-markdownlint
      coc-nvim
      coc-prettier
      coc-pyright
      coc-sh
      coc-sumneko-lua
      coc-yaml
      coc-yank
      fzf-vim
      onedark-vim
      vim-airline
      vim-commentary
      vim-fugitive
      vim-gitgutter
      vim-sensible
    ];
  };
}
