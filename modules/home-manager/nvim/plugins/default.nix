{ config, pkgs, lib, ... }:
let
  inherit (config.lib.vimUtils) pluginWithCfgFile;
  inherit (config.lib.vimUtils) pluginWithCfg;
  inherit (pkgs) vimExtraPlugins;
in {
  home.packages = with pkgs; [
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
      (ps: with ps; [ autopep8 debugpy flake8 isort yamllint pylint ]))
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

    # CMake
    cmake-format
    neocmakelsp

    # Additional
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      clangd_extensions-nvim
      coq-artifacts
      (pluginWithCfgFile {
        plugin = coq_nvim;
        file = ./coq.lua;
      })
      coq-thirdparty
      dressing-nvim
      (pluginWithCfg {
        plugin = git-worktree-nvim;
        config = ''
          require("telescope").load_extension("git_worktree")
        '';
      })
      (pluginWithCfgFile {
        plugin = harpoon;
        file = ./harpoon.lua;
      })
      (pluginWithCfg {
        plugin = kanagawa-nvim;
        config = ''
          require("kanagawa").setup({
            dimInactive = true,
            globalStatus = true,
          })

          vim.cmd.colorscheme("kanagawa")
        '';
      })
      lua-dev-nvim
      null-ls-nvim
      (pluginWithCfg {
        plugin = nvim-autopairs;
        config = ''
          require("nvim-autopairs").setup({
            enable_check_bracket_line = false,
          })
        '';
      })
      (pluginWithCfgFile {
        plugin = nvim-dap;
        file = ./dapadapters.lua;
      })
      (pluginWithCfgFile {
        plugin = nvim-dap-ui;
        file = ./dapui.lua;
      })
      nvim-dap-virtual-text
      nvim-jdtls
      (pluginWithCfgFile {
        plugin = nvim-lspconfig;
        file = ./lsp.lua;
      })
      (pluginWithCfgFile {
        plugin =
          nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars);
        file = ./treesitter.lua;
      })
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      (pluginWithCfg {
        plugin = vimExtraPlugins.staline-nvim;
        config = ''
          require("staline").setup()
        '';
      })
      telescope-dap-nvim
      (pluginWithCfgFile {
        plugin = telescope-nvim;
        file = ./telescope.lua;
      })
      (pluginWithCfg {
        plugin = undotree;
        config = ''
          vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })
        '';
      })
      vim-commentary
      (pluginWithCfg {
        plugin = vim-matchup;
        config = ''
          vim.g.matchup_matchparen_offscreen = {
            method = "status_manual",
          }
        '';
      })
      vim-repeat
      vim-surround
    ];
  };
}
