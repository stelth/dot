{ config, pkgs, lib, ... }:
let
  clangd-extensions = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "clangd-extensions";
    version = "2022-04-13";
    src = pkgs.fetchFromGitHub {
      owner = "p00f";
      repo = "clangd_extensions.nvim";
      rev = "46eeb0c93d69bdd135e2ca5dca267d44c3404a72";
      sha256 = "sha256-sBzPMJTasBZOihdjNlTtlyfH9aY74G955iQj+w5wF4o=";
    };
    meta.homepage = "https://github.com/p00f/clangd_extensions.nvim";
  };
  neovim-cmake = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neovim-cmake";
    version = "2022-05-04";
    src = pkgs.fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-cmake";
      rev = "d9e4be6bfa5f44fb04c5326db9d7093cbc6a8b93";
      sha256 = "sha256-4X+D7tCWn/BQ07O5PoSl2g2hNoKCdp69OrzciBeA2kE=";
    };
    meta.homepage = "https://Shatur/neovim-cmake";
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
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      bufferline-nvim
      clangd-extensions
      cmp-buffer
      cmp-calc
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
      neovim-cmake
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
      lldb

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
