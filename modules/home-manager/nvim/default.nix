{ config, pkgs, lib, ... }:
let
  refactoring = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "refactoring";
    version = "2022-06-10";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "refactoring.nvim";
      rev = "802667c9b8da79678a78cb10bc0286e8a2644e8d";
      sha256 = "sha256-PMcSTeHor0TGndwJCKNYT6tPmSuQz5XR9t7yt/Xr6Vc=";
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

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      clangd_extensions-nvim
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      comment-nvim
      dressing-nvim
      friendly-snippets
      gruvbox
      harpoon
      lspkind-nvim
      lua-dev-nvim
      luasnip
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-jdtls
      nvim-lspconfig
      nvim-ts-context-commentstring
      plenary-nvim
      popup-nvim
      refactoring
      telescope-fzy-native-nvim
      telescope-nvim
      undotree
      vim-fugitive
      vim-matchup
    ];

    extraPackages = with pkgs; [
      # Essentials
      tree-sitter
      fd
      fzy

      # C/C++
      clang-tools
      cppcheck

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
      cmake-language-server
      nodePackages.markdownlint-cli
      nodePackages.prettier
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
    ];
  };
}
