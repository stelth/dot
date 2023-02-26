{
  self,
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Bash
    bashate
    nodePackages.bash-language-server
    shellcheck
    shfmt

    #C/CPP
    clang-tools
    cppcheck
    cpplint

    # CMake
    cmake-format

    # Docker
    dprint
    hadolint

    # Git
    gitlint

    # Java
    google-java-format
    jdt-language-server

    # JSON
    nodePackages.fixjson
    nodePackages.vscode-json-languageserver

    # Make
    checkmake

    # Markdown
    alex
    proselint
    nodePackages.prettier
    vale
    nodePackages.write-good

    # Nix
    alejandra
    rnix-lsp
    statix

    # Python
    (python3.withPackages
      (ps: with ps; [black flake8 isort pylint]))

    # Vim
    nodePackages.vim-language-server
    vim-vint

    # YAML
    nodePackages.yaml-language-server
    yamlfix
    yamllint
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
      coc-snippets
      coc-vimlsp
      coc-yaml
      coc-yank
      fzf-checkout-vim
      fzf-vim
      onedark-vim
      undotree
      vim-airline
      vim-commentary
      vim-fugitive
      vim-gitgutter
      vim-polyglot
      vim-sensible
      vim-snippets
    ];
  };
}
