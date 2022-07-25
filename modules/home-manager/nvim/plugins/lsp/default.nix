{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    # C/C++
    clang-tools_14
    cppcheck
    lldb_14

    # Java
    jdt-language-server

    #nix
    nixfmt
    rnix-lsp
    statix

    # python
    (python3.withPackages
      (ps: with ps; [ autopep8 debugpy flake8 isort yamllint ]))
    nodePackages.pyright

    # Lua
    selene
    stylua
    sumneko-lua-language-server

    # Go
    golangci-lint
    gopls

    # Rust
    clippy
    rust-analyzer
    rustfmt

    # Shell scripting
    nodePackages.bash-language-server
    shellcheck
    shellharden
    shfmt

    # Additional
    cmake-language-server
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
  ];
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      clangd_extensions-nvim
      lua-dev-nvim
      null-ls-nvim
      nvim-jdtls
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-lspconfig;
        file = ./lsp.lua;
      })
      rust-tools-nvim
    ];
  };
}
