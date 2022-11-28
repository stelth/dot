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
      dressing-nvim
      friendly-snippets
      gitsigns-nvim
      impatient-nvim
      inc-rename-nvim
      indent-blankline-nvim
      inlay-hints-nvim
      lspkind-nvim
      lualine-nvim
      luasnip
      mini-ai
      mini-comment
      mini-jump
      mini-pairs
      mini-surround
      neodev-nvim
      noice-nvim
      null-ls-nvim
      nvim-cmp
      nvim-dap
      nvim-dap-python
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-lspconfig
      nvim-terminal-lua
      (nvim-treesitter.withPlugins (plugins: nvim-treesitter.allGrammars))
      nvim-treesitter-context
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      telescope-fzf-native-nvim
      telescope-nvim
      toggleterm-nvim
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
      vim-matchup
      which-key-nvim
    ];
  };
}
