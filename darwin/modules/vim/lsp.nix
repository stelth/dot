{
  lib,
  pkgs,
  ...
}: let
  vim9-lsp = pkgs.vimUtils.buildVimPlugin {
    pname = "vim9-lsp";
    version = "2023-09-13";
    src = pkgs.fetchFromGitHub {
      owner = "yegappan";
      repo = "lsp";
      rev = "22330283aba45977b0391234c1475e7a369371ea";
      sha256 = "uLgNOVjEfupYozeViWYriMb8rnUrFgpgwPlA4WJh3A0=";
    };
    meta.homepage = "https://github.com/yegappan/lsp";
  };
in {
  xdg.configFile."efm-langserver/config.yaml".text = import ./efm.nix {inherit lib pkgs;};

  home.packages = with pkgs;
    [
      # mandatory
      nodejs
      efm-langserver

      # language servers
      nodePackages.bash-language-server # bash
      clang-tools_16 # c/cpp
      cmake-language-server # cmake
      nodePackages.dockerfile-language-server-nodejs # docker
      nodePackages.vscode-json-languageserver # json
      marksman
      nodePackages.pyright # python
      nil # nix
      nodePackages.vim-language-server # vim
      nodePackages.yaml-language-server # yaml

      # linters / formatters
      shellcheck # bash
      shfmt # bash
      cmake-format # c/cpp
      dprint # docker
      gitlint # git
      google-java-format # java
      nodePackages.fixjson # json
      nodePackages.jsonlint # json
      nodePackages.write-good # json
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
