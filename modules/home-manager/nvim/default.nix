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
    version = "2022-06-03";
    src = pkgs.fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-cmake";
      rev = "2d8ea160fe390afd84ab66e1d12167bda45e7e21";
      sha256 = "sha256-gxs4f8JNXWlrKBj3+W316u6ImjuBBvcQ43z0+ZQUBZE=";
    };
    meta.homepage = "https://github.com/Shatur/neovim-cmake";
  };
  refactoring = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "refactoring";
    version = "2022-06-06";
    src = pkgs.fetchFromGitHub {
      owner = "ThePrimeagen";
      repo = "refactoring.nvim";
      rev = "6b4be45e8df8eb835bc2e73c05b67f69f4b5e234";
      sha256 = "sha256-sdyzc/M/HFen+03IP6jz/a+57XYBdGTmOT2KCQBPnnI=";
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
      dressing-nvim
      friendly-snippets
      gruvbox
      harpoon
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
      undotree
      vim-fugitive
      vim-markdown
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
