{ config, pkgs, lib, ... }: {
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
      (config.lib.vimUtils.pluginWithCfgFile {
        plugin = coq_nvim;
        file = ./coq.lua;
      })
      coq-thirdparty
      dressing-nvim
      {
        plugin = git-worktree-nvim;
        config = ''
          require("telescope").load_extension("git_worktree")
        '';
        type = "lua";
      }
      (config.lib.vimUtils.pluginWithCfgFile {
        plugin = harpoon;
        file = ./harpoon.lua;
      })
      {
        plugin = kanagawa-nvim;
        config = ''
          require("kanagawa").setup({
            dimInactive = true,
            globalStatus = true,
          })

          vim.cmd.colorscheme("kanagawa")
        '';
        type = "lua";
      }
      lua-dev-nvim
      null-ls-nvim
      {
        plugin = nvim-autopairs;
        config = ''
          require("nvim-autopairs").setup({
            enable_check_bracket_line = false,
          })
        '';
        type = "lua";
      }
      (config.lib.vimUtils.pluginWithCfgFile {
        plugin = nvim-dap;
        file = ./dapadapters.lua;
      })
      (config.lib.vimUtils.pluginWithCfgFile {
        plugin = nvim-dap-ui;
        file = ./dapui.lua;
      })
      nvim-dap-virtual-text
      nvim-jdtls
      (config.lib.vimUtils.pluginWithCfgFile {
        plugin = nvim-lspconfig;
        file = ./lsp.lua;
      })
      (config.lib.vimUtils.pluginWithCfgFile {
        plugin =
          nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars);
        file = ./treesitter.lua;
      })
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      telescope-dap-nvim
      (config.lib.vimUtils.pluginWithCfgFile {
        plugin = telescope-nvim;
        file = ./telescope.lua;
      })
      {
        plugin = undotree;
        config = ''
          vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })
        '';
        type = "lua";
      }
      vim-commentary
      {
        plugin = vim-matchup;
        config = ''
          vim.g.matchup_matchparen_offscreen = {
            method = "status_manual",
          }
        '';
        type = "lua";
      }
      vim-repeat
      vim-surround
    ];
  };
}
