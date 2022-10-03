{
  self,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (config.lib.vimUtils) pluginWithCfgFile;
  inherit (config.lib.vimUtils) pluginWithCfg;
in {
  home.packages = with pkgs; [
    # C/C++
    clang-tools
    cppcheck
    cpplint
    include-what-you-use
    lldb

    # Java
    jdt-language-server

    #nix
    alejandra
    deadnix
    rnix-lsp
    statix

    # python
    (python3.withPackages
      (ps: with ps; [black debugpy flake8 isort yamllint pylint]))
    nodePackages.pyright

    # Lua
    selene
    stylua
    sumneko-lua-language-server

    # Go
    golangci-lint
    gopls

    # Rust
    clippy
    rust-analyzer
    rustfmt

    # Docker
    nodePackages.dockerfile-language-server-nodejs
    hadolint

    # Shell scripting
    nodePackages.bash-language-server
    shellcheck
    shellharden
    shfmt

    # {C}Make
    checkmake
    cmake-format
    neocmakelsp

    # Additional
    actionlint
    gitlint
    nodePackages.jsonlint
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    proselint
    taplo
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      clangd_extensions-nvim
      cmp-buffer
      cmp-calc
      cmp-dap
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      (pluginWithCfg comment-nvim ''
        require('Comment').setup({
            pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
      '')
      (pluginWithCfgFile pkgs.vimExtraPlugins.dial-nvim)
      dressing-nvim
      (pluginWithCfg fidget-nvim ''
        require('fidget').setup({
                window = {
                        relative = "editor",
                    },
            })
        vim.api.nvim_create_autocmd("VimLeavePre", { command = [[silent! FidgetClose]] })
      '')
      friendly-snippets
      (pluginWithCfgFile harpoon)
      impatient-nvim
      (pluginWithCfg kanagawa-nvim ''
        require("kanagawa").setup({
          dimInactive = true,
          globalStatus = true,
        })

        vim.cmd.colorscheme("kanagawa")
      '')
      lspkind-nvim
      lua-dev-nvim
      (pluginWithCfg luasnip ''
        require("luasnip").config.set_config({
          history = false,
          -- Update more often
          updateEvents = "TextChanged,TextChangedI",
        })

        require("luasnip/loaders/from_vscode").lazy_load()
      '')
      (pluginWithCfgFile pkgs.vimExtraPlugins.neovim-tasks)
      (pluginWithCfg pkgs.vimExtraPlugins.noice-nvim ''
        require('noice').setup()
      '')
      null-ls-nvim
      (pluginWithCfg nvim-autopairs ''
        require("nvim-autopairs").setup({
          enable_check_bracket_line = false,
        })
      '')
      (pluginWithCfgFile nvim-cmp)
      (pluginWithCfgFile nvim-dap)
      nvim-dap-ui
      nvim-dap-virtual-text
      nvim-jdtls
      (pluginWithCfgFile nvim-lspconfig)
      (pluginWithCfgFile nvim-notify)
      (pluginWithCfg
        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars)) ''
          require("nvim-treesitter.configs").setup({
            highlight = { enable = true },
            incremental_selection = { enable = true },
            textobjects = { enable = true },
            indent = { enable = true },
          })

          vim.opt.foldmethod = "expr"
          vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        '')
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      (pluginWithCfgFile telescope-nvim)
      vim-dadbod
      vim-dadbod-completion
      vim-dadbod-ui
      (pluginWithCfg vim-matchup ''
        vim.g.matchup_matchparen_offscreen = {
          method = "status_manual",
        }
      '')
      vim-repeat
      vim-surround
    ];
  };
}
