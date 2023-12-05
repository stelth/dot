{
  config,
  lib,
  pkgs,
  ...
}: {
  home = lib.optionalAttrs (builtins.hasAttr "persistence" config.home) {
    persistence = {
      "/persist/home/stelth".directories = [
        ".local/share/nvim"
        ".local/state/nvim"
      ];
    };
  };

  programs.neovim = {
    enable = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;

    extraPackages = with pkgs; [
      fd
      tree-sitter

      # C/C++
      clang-tools

      # Java
      jdt-language-server

      #nix
      nil

      # python
      nodePackages.pyright

      # Lua
      lua-language-server

      # Docker
      nodePackages.dockerfile-language-server-nodejs

      # Shell scripting
      nodePackages.bash-language-server

      # {C}Make
      cmake-language-server

      # Additional
      marksman
      nodePackages.vscode-json-languageserver
      nodePackages.yaml-language-server
    ];

    extraLuaConfig = import ./settings/settings.nix {} + "\n" + import ./keymaps.nix {};

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      cmp-buffer
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      friendly-snippets
      {
        plugin = luasnip;
        config = ''
          require("luasnip").config.set_config({
          	history = true,
          	enable_autosnippets = true,
          	updateEvents = "TextChanged,TextChangedI",
          })
          require("luasnip/loaders/from_vscode").lazy_load()
        '';
        type = "lua";
      }
      gitsigns-nvim
      {
        plugin = mini-nvim;
        config = import ./settings/mini-nvim.nix {};
        type = "lua";
      }
      neodev-nvim
      {
        plugin = nvim-cmp;
        config = import ./settings/cmp-nvim.nix {};
        type = "lua";
      }
      {
        plugin = nvim-lspconfig;
        config = import ./settings/lsp.nix {inherit lib pkgs;};
        type = "lua";
      }
      {
        plugin = nvim-treesitter.withAllGrammars;
        config = import ./settings/treesitter.nix {};
        type = "lua";
      }
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      telescope-fzf-native-nvim
      {
        plugin = telescope-nvim;
        config = import ./settings/telescope.nix {};
        type = "lua";
      }
      telescope-undo-nvim
      {
        plugin = vim-matchup;
        config = ''
          vim.g.matchup_matchparen_offscreen = {
          	method = "status_manual",
          }
        '';
        type = "lua";
      }
      vim-tmux-navigator
    ];
  };
}
