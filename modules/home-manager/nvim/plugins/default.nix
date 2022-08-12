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
      (ps: with ps; [ autopep8 debugpy flake8 isort yamllint pylint ]))
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

    # Docker
    nodePackages.dockerfile-language-server-nodejs
    hadolint

    # Shell scripting
    nodePackages.bash-language-server
    shellcheck
    shellharden
    shfmt

    # CMake
    cmake-format
    neocmakelsp

    # Additional
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      clangd_extensions-nvim
      coq-artifacts
      (config.lib.vimUtils.pluginWithCfg {
        plugin = coq_nvim;
        file = ./coq.lua;
      })
      coq-thirdparty
      dressing-nvim
      (config.lib.vimUtils.pluginWithCfg {
        plugin = git-worktree-nvim;
        file = ./worktree.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = harpoon;
        file = ./harpoon.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = kanagawa-nvim;
        file = ./kanagawa.lua;
      })
      lua-dev-nvim
      null-ls-nvim
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-autopairs;
        file = ./autopairs.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-dap;
        file = ./dapadapters.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-dap-ui;
        file = ./dapui.lua;
      })
      nvim-dap-virtual-text
      nvim-jdtls
      (config.lib.vimUtils.pluginWithCfg {
        plugin = nvim-lspconfig;
        file = ./lsp.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin =
          nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars);
        file = ./treesitter.lua;
      })
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      telescope-dap-nvim
      (config.lib.vimUtils.pluginWithCfg {
        plugin = telescope-nvim;
        file = ./telescope.lua;
      })
      (config.lib.vimUtils.pluginWithCfg {
        plugin = undotree;
        file = ./undotree.lua;
      })
      vim-commentary
      (config.lib.vimUtils.pluginWithCfg {
        plugin = vim-matchup;
        file = ./vim-matchup.lua;
      })
      vim-repeat
      vim-surround
    ];
  };
}
