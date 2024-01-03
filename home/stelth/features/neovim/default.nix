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
      # misc
      fd
      nodejs
      sqlite
      tree-sitter

      # Language Servers
      clang-tools_16 # C/C++
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
      sqlfluff # SQL, does formatting and linting
      yamllint # YAML

      # none-ls formatters
      alejandra # Nix
      beautysh # Shell
      gersemi # CMake
      nodePackages.fixjson # JSON
      stylua # Lua
    ];

    extraLuaConfig = import ./settings/settings.nix {};

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      cmp-buffer
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      friendly-snippets
      {
        plugin = gitsigns-nvim;
        config =
          /*
          lua
          */
          ''
            require('gitsigns').setup({})
          '';
        type = "lua";
      }
      {
        plugin = luasnip;
        config =
          /*
          lua
          */
          ''
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
      neodev-nvim
      {
        plugin = nvim-notify;
        config =
          /*
          lua
          */
          ''
            vim.notify = require('notify')
          '';
        type = "lua";
      }
      {
        plugin = noice-nvim;
        config =
          /*
          lua
          */
          ''
            require("noice").setup({
              lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                  ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                  ["vim.lsp.util.stylize_markdown"] = true,
                  ["cmp.entry.get_documentation"] = true,
                },
              },
              -- you can enable a preset for easier configuration
              presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
              },
            })
          '';
        type = "lua";
      }
      none-ls-nvim
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
        plugin = nvim-hlslens;
        config = ''
          require('hlslens').setup()
        '';
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
        config =
          /*
          lua
          */
          ''
            vim.g.matchup_matchparen_offscreen = {
            	method = "status_manual",
            }
          '';
        type = "lua";
      }
      {
        plugin = trouble-nvim;
        config =
          /*
          lua
          */
          ''
            require('trouble').setup({
              icons = false,
            })
          '';
        type = "lua";
      }
      vim-dadbod
      vim-dadbod-completion
      {
        plugin = vim-dadbod-ui;
        config =
          /*
          lua
          */
          ''
            vim.g.db_ui_use_nerd_fonts = 1
            vim.g.db_ui_save_location = '~/.local/share/neovim/db_ui'
          '';
        type = "lua";
      }
      vim-tmux-navigator
      {
        plugin = which-key-nvim;
        config = import ./settings/keymaps.nix {};
        type = "lua";
      }
    ];
  };
}
