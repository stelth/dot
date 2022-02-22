{ config, pkgs, lib, ... }: {
  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraConfig = builtins.concatStringsSep "\n" [''
      lua << EOF
      require('settings')
      EOF
    ''];

    plugins = with pkgs.vimPlugins; [
      comment-nvim
      luasnip
      cmp-buffer
      cmp-calc
      cmp-nvim-lsp
      cmp-path
      cmp-treesitter
      cmp_luasnip
      diffview-nvim
      dressing-nvim
      friendly-snippets
      impatient-nvim
      indent-blankline-nvim
      lightspeed-nvim
      lua-dev-nvim
      null-ls-nvim
      nvim-autopairs
      bufferline-nvim
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-hlslens
      nvim-jdtls
      nvim-lspconfig
      nvim-terminal-lua
      toggleterm-nvim
      nvim-treesitter
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      tabular
      telescope-fzy-native-nvim
      telescope-project-nvim
      telescope-nvim
      tokyonight-nvim
      vim-markdown
      vim-matchup
      vim-mergetool
    ];

    extraPackages = with pkgs; [
      # Essentials
      tree-sitter
      fd
      fzy

      # C/C++
      clang-tools
      cppcheck

      # Haskell
      haskell-language-server
      haskellPackages.brittany
      haskellPackages.cabal-fmt

      # Java
      jdt-language-server

      #nix
      nixfmt
      rnix-lsp
      statix

      # python
      (python3.withPackages (ps: with ps; [ autopep8 flake8 isort yamllint ]))
      nodePackages.pyright

      # Lua
      selene
      stylua
      sumneko-lua-language-server

      # Shell scripting
      nodePackages.bash-language-server
      shellcheck
      shellharden
      shfmt

      # Additional
      stable.cmake-language-server
      nodePackages.markdownlint-cli
      nodePackages.prettier
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
    ];
  };
}
