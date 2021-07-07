{ config, pkgs, home-manager, ... }:

{
  home.packages = with pkgs; [
    clang-tools # clangd
    cmake-language-server
    neovim-nightly
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.eslint_d
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.pyright
    nodePackages.stylelint
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    python39Packages.autopep8
    python39Packages.debugpy
    python39Packages.flake8
    rnix-lsp
    selene
    stylua
    sumneko-lua-language-server
    texlab
    vim-vint
    yamllint
  ];
}
