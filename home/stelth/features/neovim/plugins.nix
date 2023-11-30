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
      # lsp servers
      nodePackages.bash-language-server # bash
      clang-tools # c/c++ clangd
      nodePackages.vscode-json-languageserver # json files
      lua-language-server # lua
      marksman # markdown
      neocmakelsp # cmake
      nil # nix
      python311Packages.python-lsp-server # python
      taplo # toml
      typos # all, checks for spelling errors
      yaml-language-server # yaml
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
      inc-rename-nvim
      luasnip
      mini-nvim
      neodev-nvim
      neogit
      noice-nvim
      nvim-cmp
      nvim-hlslens
      nvim-lspconfig
      nvim-navic
      nvim-notify
      nvim-terminal-lua
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
