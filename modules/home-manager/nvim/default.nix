{ config, pkgs, lib, ... }: {
  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
  home.packages = with pkgs; [
    clang-tools # clangd
    cppcheck
    hadolint
    jdt-language-server
    lldb
    lua53Packages.luacheck
    neovim-nightly
    nixfmt
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
    nodePackages.write-good
    nodePackages.yaml-language-server
    proselint
    python3Packages.isort
    python3Packages.pylint
    rnix-lsp
    selene
    shellcheck
    shellharden
    shfmt
    stable.cmake-language-server
    stylua
    sumneko-lua-language-server
    tree-sitter
    uncrustify
    vim-vint
    yamllint
  ];
}
