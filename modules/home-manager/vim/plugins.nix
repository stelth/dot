{pkgs, ...}: {
  home.packages = with pkgs; [
    # Bash
    nodePackages.bash-language-server
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
    jdt-language-server

    # JSON
    nodePackages.fixjson
    nodePackages.vscode-json-languageserver

    # Make
    checkmake

    # Markdown
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
      auto-pairs
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
      coc-yank
      fzf-vim
      is-vim
      onedark-vim
      undotree
      vim-abolish
      vim-commentary
      vim-dispatch
      vim-endwise
      vim-eunuch
      vim-flagship
      vim-fugitive
      vim-polyglot
      vim-repeat
      vim-sensible
      vim-signify
      vim-sleuth
      vim-snippets
      vim-surround
      vim-tmux-navigator
      vim-unimpaired
      vim-vinegar
    ];
  };
}
