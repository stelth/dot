{pkgs, ...}: let
  neocmakelsp = pkgs.rustPlatform.buildRustPackage rec {
    pname = "neocmakelsp";
    version = "0.6.16";

    src = pkgs.fetchFromGitHub {
      owner = "Decodetalkers";
      repo = "neocmakelsp";
      rev = "v${version}";
      hash = "sha256-tQlRo/g4FlR26CrVagzgHvPM4PQ29kSa1ziXFFH83h4=";
    };

    cargoHash = "sha256-1WoFceHua8GTZg1XlrRWdu3o8EE4eOkfNUszxOiod6A=";
  };
in {
  programs.neovim = {
    extraPackages = with pkgs; [
      ### lsp servers
      nodePackages.bash-language-server # bash
      clang-tools_16 # c/c++ clangd
      nodePackages.vscode-json-languageserver # json files
      lua-language-server # lua
      marksman # markdown
      neocmakelsp # cmake
      nil # nix
      python311Packages.python-lsp-server # python
      taplo # toml
      yaml-language-server # yaml

      ### linters
      # Markdown
      nodePackages.alex
      markdownlint-cli2
      # Python
      bandit
      python311Packages.flake8
      pylint
      # git commit messages
      commitlint
      # C / C++
      cpplint
      # json / jsonc
      nodePackages.jsonlint
      # lua
      selene
      # bash
      shellcheck
      # nix
      statix
      # all
      typos
      # yaml
      yamllint

      ### Formatters
      # cmake
      cmake-format
      # json
      prettierd
      # lua
      stylua
      # nix
      alejandra
      # python
      black
      isort
      # shell
      shfmt
      # toml
      taplo
    ];

    plugins = with pkgs.vimPlugins; [
      barbecue-nvim
      cmp-buffer
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      dressing-nvim
      friendly-snippets
      formatter-nvim
      inc-rename-nvim
      lsp-inlayhints-nvim
      luasnip
      mini-nvim
      neodev-nvim
      neogit
      noice-nvim
      nvim-cmp
      nvim-hlslens
      nvim-lint
      nvim-lspconfig
      nvim-navic
      nvim-notify
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      nvim-web-devicons
      rose-pine
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-undo-nvim
      vim-matchup
      vim-tmux-navigator
    ];
  };
}
