{ config, pkgs, lib, ... }: {
  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
  home.packages = with pkgs; [
    clang-tools # clangd
    stable.cmake-language-server
    hadolint
    jdt-language-server
    neovim-nightly
    nixfmt
    nodePackages.bash-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.eslint_d
    nodePackages.markdownlint-cli
    nodePackages.prettierd
    nodePackages.pyright
    nodePackages.stylelint
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    nodePackages.vscode-json-languageserver
    nodePackages.write-good
    nodePackages.yaml-language-server
    rnix-lsp
    selene
    shellcheck
    shfmt
    stylua
    sumneko-lua-language-server
    texlab
    tree-sitter
    uncrustify
    vim-vint
    yamllint
  ];
}
