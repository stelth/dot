{
  config,
  lib,
  pkgs,
  ...
}: {
  xdg.configFile = {
    "nvim/lua" = {
      recursive = true;
      source = ./lua;
    };
  };

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

    extraPackages = with pkgs; [fd tree-sitter];

    extraLuaConfig = ''
      require('settings')
      require('plugins')
      require('keymaps')
    '';

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      cmp-buffer
      cmp-git
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      friendly-snippets
      luasnip
      mini-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      telescope-fzf-native-nvim
      telescope-nvim
      telescope-undo-nvim
      vim-matchup
    ];
  };
}
