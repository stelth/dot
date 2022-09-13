{ self, config, pkgs, lib, ... }:
let
  inherit (config.lib.vimUtils) pluginWithCfgFile;
  inherit (config.lib.vimUtils) pluginWithCfg;
in {
  home.packages = with pkgs; [
    # C/C++
    clang-tools_14
    cppcheck
    cpplint

    # Java
    jdt-language-server

    #nix
    nixfmt
    rnix-lsp
    statix

    # python
    (python3.withPackages
      (ps: with ps; [ black debugpy flake8 isort yamllint pylint ]))
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
    nodePackages.markdownlint-cli
    nodePackages.prettier
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    proselint
  ];

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      clangd_extensions-nvim
      coq-artifacts
      (pluginWithCfgFile coq_nvim)
      coq-thirdparty
      dressing-nvim
      (pluginWithCfgFile harpoon)
      (pluginWithCfg kanagawa-nvim ''
        require("kanagawa").setup({
          dimInactive = true,
          globalStatus = true,
        })

        vim.cmd.colorscheme("kanagawa")
      '')
      lua-dev-nvim
      null-ls-nvim
      (pluginWithCfg nvim-autopairs ''
        require("nvim-autopairs").setup({
          enable_check_bracket_line = false,
        })
      '')
      nvim-jdtls
      (pluginWithCfgFile nvim-lspconfig)
      (pluginWithCfgFile nvim-notify)
      (pluginWithCfgFile
        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars)))
      nvim-ts-context-commentstring
      nvim-web-devicons
      rust-tools-nvim
      (pluginWithCfgFile telescope-nvim)
      (pluginWithCfg undotree ''
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undo Tree" })
      '')
      vim-commentary
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
