{ config, pkgs, lib, ... }:
let
  leap-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "leap-nvim";
    version = "2022-06-25";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap.nvim";
      rev = "19442875412a7c82fce2ddf548d825b9dc6c48bc";
      sha256 = "sha256-d3HOGuDMcnTRoxrG0QLns1EZsCZqftvg1K6bDwS8pYY=";
    };
    meta.homepage = "https://github.com/ggandor/leap.nvim";
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
      git-worktree-nvim
      harpoon
      leap-nvim
      lspkind-nvim
      lsp_signature-nvim
      lua-dev-nvim
      luasnip
      neogit
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-jdtls
      nvim-lspconfig
      nvim-notify
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      nvim-ts-context-commentstring
      telescope-dap-nvim
      telescope-file-browser-nvim
      telescope-nvim
      tokyonight-nvim
      undotree
      vim-matchup
    ];

    extraPackages = with pkgs; [
      # Essentials
      tree-sitter
      fd

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
      (python3.withPackages
        (ps: with ps; [ autopep8 debugpy flake8 isort yamllint ]))
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
