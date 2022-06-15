{ config, pkgs, lib, ... }:
let
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
      nvim-notify
      nvim-ts-context-commentstring
      plenary-nvim
      popup-nvim
      telescope-dap-nvim
      telescope-fzy-native-nvim
      telescope-nvim
      tokyonight-nvim
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
      clang-tools_14
      cppcheck
      lldb_14

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
