{ config, pkgs, lib, ... }:
let
  refactoring = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "refactoring";
    version = "2022-03-18";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "refactoring.nvim";
      rev = "79c0bc1797f80e4a260e08a0aee18c9a2e1b437b";
      sha256 = "sha256-zSinqDb10AvS7FdCDUS9PgPHThRaSNe8rQAm2gCzx2M=";
    };
    meta.homepage = "https://github.com/ThePrimeagen/refactoring.nvim";
  };
in {
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
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      bufferline-nvim
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp-treesitter
      cmp_luasnip
      comment-nvim
      diffview-nvim
      dressing-nvim
      friendly-snippets
      gitsigns-nvim
      impatient-nvim
      indent-blankline-nvim
      lightspeed-nvim
      lua-dev-nvim
      luasnip
      neogit
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-hlslens
      nvim-jdtls
      nvim-lspconfig
      nvim-terminal-lua
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      project-nvim
      refactoring
      tabular
      telescope-frecency-nvim
      telescope-fzy-native-nvim
      telescope-nvim
      toggleterm-nvim
      tokyonight-nvim
      undotree
      vim-illuminate
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
