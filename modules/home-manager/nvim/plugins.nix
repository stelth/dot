{
  self,
  config,
  pkgs,
  lib,
  ...
}: {
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
    marksman
    nodePackages.jsonlint
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    proselint
    taplo
  ];

  programs.neovim = {
    plugins = with pkgs.vimExtraPlugins; [
      cmp-buffer
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      friendly-snippets
      git-worktree-nvim
      impatient-nvim
      inc-rename-nvim
      kanagawa-nvim
      luasnip
      mini-comment
      mini-move
      mini-pairs
      mini-statusline
      neodev-nvim
      neogit
      null-ls-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-terminal-lua
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-web-devicons
      rust-tools-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-undo-nvim
      vim-matchup
    ];
  };
}
