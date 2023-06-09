{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."efm-langserver/config.yaml".text = import ./efm.nix {inherit lib pkgs;};

  home.packages = with pkgs;
    [
      nodejs
      efm-langserver

      # Bash
      nodePackages.bash-language-server
      shellcheck
      shfmt

      #C/CPP
      clang-tools
      cpplint

      # CMake
      cmake-language-server
      cmake-format

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
      nodePackages.prettier
      vale
      nodePackages.write-good

      # Nix
      alejandra
      statix

      # Python
      nodePackages.pyright
      (python3.withPackages
        (ps: with ps; [black flake8 isort pylint]))

      # Vim
      nodePackages.vim-language-server
      vim-vint

      # YAML
      nodePackages.yaml-language-server
      yamllint
    ]
    ++ lib.optionals (!pkgs.stdenvNoCC.isDarwin) [checkmake];

  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      vim9-lsp
    ];
  };
}
