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
    cmake-language-server

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
      cmp-buffer
      cmp-calc
      cmp-dap
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      comment-nvim
      pkgs.vimExtraPlugins.dial-nvim
      diffview-nvim
      dressing-nvim
      friendly-snippets
      harpoon
      impatient-nvim
      indent-blankline-nvim
      pkgs.vimExtraPlugins.inlay-hints-nvim
      lspkind-nvim
      pkgs.vimExtraPlugins.lualine-nvim
      luasnip
      pkgs.vimExtraPlugins.neodev-nvim
      pkgs.vimExtraPlugins.neovim-tasks
      pkgs.vimExtraPlugins.noice-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-python
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-jdtls
      nvim-lspconfig
      pkgs.vimExtraPlugins.nvim-navic
      nvim-surround
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      telescope-file-browser-nvim
      telescope-nvim
      tokyonight-nvim
      twilight-nvim
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
      vim-illuminate
      vim-matchup
      vim-repeat
      which-key-nvim
      pkgs.vimExtraPlugins.yanky-nvim
      zen-mode-nvim
    ];
  };
}
