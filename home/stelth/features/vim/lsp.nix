{
  lib,
  pkgs,
  ...
}: {
  xdg.configFile."efm-langserver/config.yaml".text = import ./efm.nix {inherit lib pkgs;};

  home.packages = with pkgs;
    [
      # mandatory
      nodejs
      efm-langserver

      # language servers
      nodePackages.bash-language-server # bash
      clang-tools # c/cpp
      cmake-language-server # cmake
      nodePackages.dockerfile-language-server-nodejs # docker
      nodePackages.vscode-json-languageserver # json
      nodePackages.pyright # python
      nil # nix
      nodePackages.vim-language-server # vim
      nodePackages.yaml-language-server # yaml

      # linters / formatters
      shellcheck # bash
      shfmt # bash
      cmake-format # c/cpp
      hadolint # docker
      gitlint
      nodePackages.fixjson # json
      vale # markdown
      alejandra # nix
      statix # nic
      (python3.withPackages (ps: with ps; [black flake8 isort pylint])) # python
      vim-vint # vim
      yamllint # yaml
    ]
    ++ lib.optionals (!pkgs.stdenvNoCC.isDarwin) [checkmake];

  programs.vim = {
    plugins = with pkgs.vimPlugins; [
      vim9-lsp
    ];
  };
}
