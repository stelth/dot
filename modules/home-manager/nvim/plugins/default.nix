{
  self,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.lib.vimUtils) pluginWithCfg;
in {
  home.packages = with pkgs; [
    # C/C++
    clang-tools
    cppcheck
    cpplint
    include-what-you-use
    lldb

    # Java
    jdt-language-server

    #nix
    alejandra
    deadnix
    rnix-lsp
    statix

    # python
    (python3.withPackages
      (ps: with ps; [black debugpy flake8 isort yamllint pylint]))
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

    # {C}Make
    checkmake
    cmake-format
    neocmakelsp

    # Additional
    actionlint
    gitlint
    nodePackages.jsonlint
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    proselint
    taplo
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      clangd_extensions-nvim
      cmp-buffer
      cmp-calc
      cmp-dap
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      (pluginWithCfg comment-nvim)
      (pluginWithCfg pkgs.vimExtraPlugins.dial-nvim)
      dressing-nvim
      friendly-snippets
      (pluginWithCfg harpoon)
      impatient-nvim
      (pluginWithCfg kanagawa-nvim)
      lspkind-nvim
      lua-dev-nvim
      (pluginWithCfg luasnip)
      (pluginWithCfg pkgs.vimExtraPlugins.neovim-tasks)
      null-ls-nvim
      (pluginWithCfg nvim-autopairs)
      (pluginWithCfg nvim-cmp)
      (pluginWithCfg nvim-dap)
      nvim-dap-ui
      nvim-dap-virtual-text
      {
        plugin = nvim-jdtls;
        type = "lua";
        runtime = {
          "ftplugin/java.lua".text = builtins.readFile ./runtime/java.lua;
        };
      }
      (pluginWithCfg nvim-lspconfig)
      (pluginWithCfg nvim-notify)
      (pluginWithCfg nvim-surround)
      (pluginWithCfg
        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars)))
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      (pluginWithCfg telescope-nvim)
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
      (pluginWithCfg vim-matchup)
      vim-repeat
    ];
  };
}
