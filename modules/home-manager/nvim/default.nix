{ config, pkgs, lib, ... }:
let
  clangd-extensions = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "clangd-extensions";
    version = "2022-05-19";
    src = pkgs.fetchFromGitHub {
      owner = "p00f";
      repo = "clangd_extensions.nvim";
      rev = "22bf787361729eb9e473cfc97386b09fd917402c";
      sha256 = "sha256-i2ZCgxP7y0g4AduUmIpYS4ARCf20SkbruOPM0FF/X/M=";
    };
    meta.homepage = "https://github.com/p00f/clangd_extensions.nvim";
  };
  neovim-cmake = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "neovim-cmake";
    version = "2022-05-14";
    src = pkgs.fetchFromGitHub {
      owner = "Shatur";
      repo = "neovim-cmake";
      rev = "5e2eee8e5299d86949e498c3bf4b56c7a241db34";
      sha256 = "sha256-rs78Y2ndmgC7xmFa879Ipjr34/N6LnHJdahOLEX92XE=";
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
    package = pkgs.neovim-unwrapped;
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
