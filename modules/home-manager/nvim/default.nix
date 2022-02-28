{ config, pkgs, lib, ... }:
let
  impatient = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "impatient";
    version = "2022-02-24";
    src = pkgs.fetchFromGitHub {
      owner = "lewis6991";
      repo = "impatient.nvim";
      rev = "7abfc924714d3b7f19f3674cca0231cf6ef2050f";
      sha256 = "sha256-f+08N88A5XkUR28HXYEc537iSUHAqdVQFSpSGb1GABM=";
    };
    meta.homepage = "https://github.com/lewis6991/impatient.nvim/";
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
      cmp-nvim-lsp
      cmp-path
      cmp-treesitter
      cmp_luasnip
      comment-nvim
      diffview-nvim
      dressing-nvim
      friendly-snippets
      impatient
      indent-blankline-nvim
      lightspeed-nvim
      lua-dev-nvim
      luasnip
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
      tabular
      telescope-frecency-nvim
      telescope-fzy-native-nvim
      telescope-nvim
      telescope-project-nvim
      toggleterm-nvim
      tokyonight-nvim
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
