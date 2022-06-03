{ config, pkgs, lib, ... }:
let
  clangd-extensions = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "clangd-extensions";
    version = "2022-05-30";
    src = pkgs.fetchFromGitHub {
      owner = "p00f";
      repo = "clangd_extensions.nvim";
      rev = "81b56d41d8ab791509a8464b0afc54144be9f23d";
      sha256 = "sha256-DcBrpkZDvj2SqmXCdctt+0q8pt8TPqo2rYM2e5eNqo4=";
    };
    meta.homepage = "https://github.com/p00f/clangd_extensions.nvim";
  };
  neovim-cmake = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neovim-cmake";
    version = "2022-05-25";
    src = pkgs.fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-cmake";
      rev = "196bd95a53305930ffff2566ffaaa6056d8f5fc3";
      sha256 = "sha256-gMzuNKw2DUOn2Sq/pS4BrgcrAmZa5FiDjr2VYvDM0co=";
    };
    meta.homepage = "https://github.com/Shatur/neovim-cmake";
  };
  refactoring = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "refactoring";
    version = "2022-06-01";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "refactoring.nvim";
      rev = "8aae61389d3654335b2fd913d137f4908d482717";
      sha256 = "sha256-NMP0ftIhe1GezfL+IoTUYiio4M72HlVW492z82xlZko=";
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
      clangd-extensions
      cmp-buffer
      cmp-calc
      cmp-cmdline
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-path
      cmp_luasnip
      comment-nvim
      diffview-nvim
      dressing-nvim
      friendly-snippets
      harpoon
      impatient-nvim
      lspkind-nvim
      lua-dev-nvim
      luasnip
      neovim-cmake
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-jdtls
      nvim-lspconfig
      nvim-terminal-lua
      nvim-ts-context-commentstring
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      project-nvim
      refactoring
      tabular
      telescope-dap-nvim
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
      # lldb

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
