{pkgs, ...}: {
  home.packages = with pkgs;
    [
      # Bash
      shellcheck
      shfmt

      #C/CPP
      clang-tools
      cpplint
      gdb

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
      fzf-vim
      is-vim
      markdown-preview-nvim
      onedark-vim
      undotree
      vim-abolish
      vim-cmake
      vim-commentary
      vim-dispatch
      vim-endwise
      vim-eunuch
      vim-flagship
      vim-fugitive
      vim-manpager
      vim-pager
      vim-polyglot
      vim-repeat
      vim-sensible
      vim-signify
      vim-sleuth
      vim-snippets
      vim-speeddating
      vim-surround
      vim-system-copy
      vim-tmux-navigator
      vim-unimpaired
      vim-vinegar
    ];
  };
}
