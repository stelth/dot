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
      catppuccin
      cmp-buffer
      cmp-calc
      cmp-dap
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      dial-nvim
      dressing-nvim
      flit-nvim
      friendly-snippets
      gitsigns-nvim
      impatient-nvim
      inc-rename-nvim
      indent-blankline-nvim
      inlay-hints-nvim
      leap-ast-nvim
      lspkind-nvim
      lualine-nvim
      luasnip
      mini-ai
      mini-bufremove
      mini-comment
      mini-pairs
      mini-surround
      neodev-nvim
      neovim-tasks
      noice-nvim
      null-ls-nvim
      nvim-cmp
      nvim-dap
      nvim-dap-python
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-lspconfig
      nvim-notify
      nvim-terminal-lua
      nvim-treesitter.withAllGrammars
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-treesitter-textsubjects
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-undo-nvim
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
      vim-matchup
      which-key-nvim
      zen-mode-nvim
    ];
  };
}
