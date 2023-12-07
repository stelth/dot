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

      # Language Servers
      clang-tools # C/C++
      nil # Nix
      nodePackages.pyright # Python
      lua-language-server # Lua
      nodePackages.bash-language-server # Shell
      cmake-language-server # CMake
      marksman # Markdown
      nodePackages.vscode-json-languageserver # JSON
      nodePackages.yaml-language-server # YAML

      # none-ls linters
      shellcheck # Shell
      statix # Nix
      checkmake # Makefile
      cmake-format # CMake
      gitlint # Git commits
      deadnix # Nix
      (python3.withPackages (ps: with ps; [black flake8 pylint reorder-python-imports])) # Python
      nodePackages.jsonlint # JSON
      markdownlint-cli # Markdown
      selene # Lua
      yamllint # YAML

      # none-ls formatters
      alejandra # Nix
      beautysh # Shell
      nodePackages.fixjson # JSON
      stylua # Lua
    ];

    extraLuaConfig = import ./settings/settings.nix {} + "\n" + import ./keymaps.nix {};

    plugins = with pkgs.vimPlugins; [
      auto-pairs
      catppuccin-nvim
      cmp-buffer
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      friendly-snippets
      {
        plugin = gitsigns-nvim;
        config = ''
          require('gitsigns').setup({})
        '';
        type = "lua";
      }
      {
        plugin = luasnip;
        config = ''
          plugin = luasnip;
          require("luasnip").config.set_config({
          	history = true,
          	enable_autosnippets = true,
          	updateEvents = "TextChanged,TextChangedI",
          })
          require("luasnip/loaders/from_vscode").lazy_load()
        '';
        type = "lua";
      }
      {
        plugin = mini-nvim;
        config = import ./settings/mini-nvim.nix {};
        type = "lua";
      }
      neodev-nvim
      {
        plugin = nvim-notify;
        config = ''
          vim.notify = require('notify')
        '';
        type = "lua";
      }
      {
        plugin = nvim-cmp;
        config = import ./settings/cmp-nvim.nix {};
        type = "lua";
      }
      none-ls-nvim
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
        plugin = toggleterm-nvim;
        config = ''
          require('toggleterm').setup({
            open_mapping = "<leader>tt"
          })
        '';
        type = "lua";
      }
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
