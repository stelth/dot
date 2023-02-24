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
    bashate
    shellcheck
    shfmt

    # {C}Make
    cmake-format

    # Additional
    actionlint
    gitlint
    nodePackages.jsonlint
    proselint
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
      coc-vimlsp
      coc-yaml
      coc-yank
      fzf-checkout-vim
      fzf-vim
      onedark-vim
      vim-airline
      vim-commentary
      vim-fugitive
      vim-gitgutter
      vim-polyglot
      vim-sensible
    ];
  };
}
