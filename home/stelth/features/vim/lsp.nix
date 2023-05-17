{pkgs, ...}: {
  home.packages = with pkgs;
    [
      nodejs

      # Bash
      nodePackages.bash-language-server
      shellcheck
      shfmt

      #C/CPP
      clang-tools
      cpplint

      # CMake
      cmake-format
      cmake-language-server

      # Docker
      nodePackages.dockerfile-language-server-nodejs
      dprint
      hadolint

      # Git
      gitlint

      # Java
      google-java-format

      # JSON
      nodePackages.fixjson
      nodePackages.vscode-json-languageserver

      # Markdown
      marksman
      nodePackages.prettier
      vale
      nodePackages.write-good

      # Nix
      alejandra
      nil
      statix

      # Python
      nodePackages.pyright
      (python3.withPackages
        (ps: with ps; [black flake8 isort pylint]))

      # Vim
      nodePackages.vim-language-server
      vim-vint

      # YAML
      yamllint
      nodePackages.yaml-language-server
    ]
    ++ lib.optionals (!pkgs.stdenvNoCC.isDarwin) [checkmake];

  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      ale
      asyncomplete-buffer-vim
      asyncomplete-file-vim
      asyncomplete-lsp-vim
      asyncomplete-vim
      vim-lsp
      vim-lsp-ale
      vim-lsp-settings
    ];
  };
}
